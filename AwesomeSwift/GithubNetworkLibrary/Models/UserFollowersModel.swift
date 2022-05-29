//
//  UserFollowersModel.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 05/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation

class UserFollowersModel:Codable {
    let items: [UserInfoModel]
    
    enum CodingKeys:String, CodingKey {
        case items = ""
    }
}
