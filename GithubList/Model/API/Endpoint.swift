//
//  Endpoint.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case getUsers(sinceId: String?)
    case getUser(login: String)
    case getRepositories(login: String, page: Int)
    
    var headers: [String : String] {
        get {
            switch self {
            default:
                return [:]
            }
        }
    }
    
    var parameters: [String : Any] {
        get {
            switch self {
            case .getUsers(let sinceId):
                if let sinceId = sinceId {
                    return ["since" : sinceId]
                } else {
                    return [:]
                }
            case .getRepositories(_, let page):
                return ["type" : "all", "per_page" : 100, "page" : page]
            default:
                return [:]
            }
        }
    }
    
    var path: String {
        get {
            switch self {
            case .getUsers:
                return "users"
            case .getUser(let login):
                return "users/\(login)"
            case .getRepositories(let login, _):
                return "users/\(login)/repos"
            }
        }
    }
    
    var method: HTTPMethod {
        get {
            switch self {
            case .getUsers, .getUser, .getRepositories:
                return .get
            }
        }
    }
    
}
