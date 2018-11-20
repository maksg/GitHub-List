//
//  APIRequest.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class APIRequest: APIRequestProtocol {
    
    private var apiURL: String {
        get {
            return "https://api.github.com/"
        }
    }
    
    func getUser(login: String, completionHandler: @escaping (User?, Error?) -> Void) {
        let request = Request(withURL: self.apiURL, forEndpoint: .getUser(login: login))
        request.makeRequest(completionHandler: completionHandler)
    }
    
    func getUsers(sinceId: String?, completionHandler: @escaping ([User]?, Error?) -> Void) {
        let request = Request(withURL: self.apiURL, forEndpoint: .getUsers(sinceId: sinceId))
        request.makeRequest(completionHandler: completionHandler)
    }
    
    func getRepositories(userLogin: String, page: Int, completionHandler: @escaping ([Repository]?, Error?) -> Void) {
        let request = Request(withURL: self.apiURL, forEndpoint: .getRepositories(login: userLogin, page: page))
        request.makeRequest(completionHandler: completionHandler)
    }
    
}
