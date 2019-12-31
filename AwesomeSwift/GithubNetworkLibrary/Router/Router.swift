//
//  Router.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 25/11/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import Foundation

// GitHub API Details
/*
 * User details: https://api.github.com/users/<username>
 * User's followers: https://api.github.com/users/<username>/followers
 * Example (If the search term ‘torvalds’):
 * User: https://api.github.com/search/users?q=torvalds&page=1
 * Followers: https://api.github.com/users/torvalds/followers
 */


enum Router {
    case searchUser
    case getUserDetails
    case getUserFollowers
    
    var scheme: String {
        switch self {
        case .searchUser, .getUserDetails, .getUserFollowers:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .searchUser, .getUserDetails, .getUserFollowers:
            return "api.github.com"
        }
    }
    
    var path: String {
        switch self {
        case .searchUser:
            return "/search/users"
        case .getUserDetails:
            return "/users/"
        case .getUserFollowers:
            return "/users/"
        }
    }   
    
    var method: String {
        switch self {
        case .searchUser, .getUserDetails, .getUserFollowers:
            return "GET"
        }
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    mutating func appendPath(with searchText: String) {
        self.path.append(searchText)
    }
}

