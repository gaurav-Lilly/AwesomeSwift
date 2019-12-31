//
//  UsersModel.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 29/11/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation

struct UsersModel: Codable {
    let totalCount:Int
    let isResultIncomplete:Bool
    let items:[UserInfoModel]
    
    enum CodingKeys:String, CodingKey {
        case totalCount = "total_count"
        case isResultIncomplete = "incomplete_results"
        case items
    }
}
