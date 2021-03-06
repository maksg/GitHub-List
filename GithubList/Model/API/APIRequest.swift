//
//  APIRequest.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class APIRequest: APIRequestProtocol {
    
    // MARK: Private Properties
    
    private var request: RequestProtocol
    
    // MARK: Initialization
    
    init(withRequest request: RequestProtocol) {
        self.request = request
    }
    
    // MARK: Methods
    
    func getUser(login: String, completionHandler: @escaping (User?, Error?) -> Void) {
        request.endpoint = .getUser(login: login)
        request.makeRequest(completionHandler: completionHandler)
    }
    
    func getUsers(sinceId: String?, completionHandler: @escaping ([User]?, Error?) -> Void) {
        request.endpoint = .getUsers(sinceId: sinceId)
        request.makeRequest(completionHandler: completionHandler)
    }
    
    func getRepositories(userLogin: String, page: Int, completionHandler: @escaping ([Repository]?, Error?) -> Void) {
        request.endpoint = .getRepositories(login: userLogin, page: page)
        request.makeRequest(completionHandler: completionHandler)
    }
    
}
