//
//  Repository.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

struct Repository: ResponseDataProtocol, Equatable {
    
    var id: Int
    var fullName: String
    var createdDate: Date
    var updatedDate: Date
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case url = "html_url"
    }
    
}
