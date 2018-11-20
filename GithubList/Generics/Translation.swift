//
//  Translation.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class Translation {
    
    enum Alert: String {
        case confirm = "alert_confirm"
        case cancel = "alert_cancel"
    }
    
    enum Error: String {
        case title = "error_title"
        case `default` = "error_default"
        case requestLimitReached = "error_request_limit_reached"
    }
    
    enum Warning: String {
        case title = "warning_title"
        case requestLimit = "warning_request_limit"
    }
    
    enum Users: String {
        case title = "users_title"
        case publicRepositories = "users_public_repositories"
    }
    
    enum Repositories: String {
        case title = "repositories_title"
        case createdAt = "repositories_created_at"
        case updatedAt = "repositories_updated_at"
    }
    
}

