//
//  UserApiManager.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 29/11/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation

class UserApiManager {
    
    class func getSearchedUsers(searchString: String,  completionHandler: @escaping (UsersModel?, Error?) -> ()) {
        ServiceLayer.request(router: Router.searchUser, queryParameters: ["q":searchString,"page":"1"], path: nil) {(result: Result<UsersModel, Error>) in
            switch result {
            case .success(let userModel):
                completionHandler(userModel, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    class func getUserFollowersList(searchString: String,  completionHandler: @escaping ([UserInfoModel]?, Error?) -> ()) {
        let path = searchString + "/followers"
        ServiceLayer.request(router: Router.getUserFollowers, queryParameters: nil, path: path) {(result: Result<[UserInfoModel], Error>) in
            switch result {
            case .success(let arrayOfUserInfoModel):
                completionHandler(arrayOfUserInfoModel, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
