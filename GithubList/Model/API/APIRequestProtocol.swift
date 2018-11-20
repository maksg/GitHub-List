//
//  APIRequestProtocol.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

protocol APIRequestProtocol {
    
    func getUser(login: String, completionHandler: @escaping (User?, Error?) -> Void)
    func getUsers(sinceId: String?, completionHandler: @escaping ([User]?, Error?) -> Void)
    func getRepositories(userLogin: String, page: Int, completionHandler: @escaping ([Repository]?, Error?) -> Void)
    
}
