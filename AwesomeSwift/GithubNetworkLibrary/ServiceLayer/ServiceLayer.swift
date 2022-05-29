//
//  ServiceLayer.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 25/11/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation

class ServiceLayer {
    
    class func request<T: Codable>(router: Router, queryParameters:[String:String]?, path: String?, completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        
        if let queryParamters = queryParameters {
            components.setQueryItems(with: queryParamters)
        }
        
        if let path = path {
            components.path.append(path)
        }
        
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession.init(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data,response,error in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard response != nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        
        dataTask.resume()
    }
}
