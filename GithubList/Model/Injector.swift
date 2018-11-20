//
//  Injector.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class Injector: InjectorProtocol {
    
    // MARK: Properties
    
    private(set) var apiRequest: APIRequestProtocol
    
    // MARK: Initialization
    
    init(apiRequest: APIRequestProtocol) {
        self.apiRequest = apiRequest
    }
    
}
