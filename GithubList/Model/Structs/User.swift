//
//  User.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

struct User: ResponseDataProtocol {
    
    var id: Int
    var login: String
    var avatarUrl: String
    var publicRepositories: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case publicRepositories = "public_repos"
    }
    
}
