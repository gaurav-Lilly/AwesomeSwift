//
//  UserInfoModel.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 29/11/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation

struct UserInfoModel:Codable {
    let id:Int
    let url:String
    let loginName:String
    let followersUrl:String
    
    enum CodingKeys:String, CodingKey {
        case followersUrl = "followers_url"
        case id
        case url
        case loginName = "login"
    }
}
