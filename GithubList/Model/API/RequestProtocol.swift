//
//  RequestProtocol.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    
    // MARK: Properties
    
    var apiURL: String { get }
    var endpoint: Endpoint! { get set }
    
    // MARK: Initialization
    
    init(withURL apiUrl: String)
    
    // MARK: Methods
    
    func getRequest() throws -> URLRequest
    func makeRequest(completionHandler: @escaping (Error?) -> Void)
    func makeRequest<ResponseData: ResponseDataProtocol>(completionHandler: @escaping (ResponseData?, Error?) -> Void)
    
}
