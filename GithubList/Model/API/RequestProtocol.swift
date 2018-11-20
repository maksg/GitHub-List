//
//  RequestProtocol.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    
    // MARK: Initialization
    
    init(withURL apiUrl: String, forEndpoint endpoint: Endpoint)
    
    // MARK: Methods
    
    func makeRequest(completionHandler: @escaping (Error?) -> Void)
    func makeRequest<ResponseData: ResponseDataProtocol>(completionHandler: @escaping (ResponseData?, Error?) -> Void)
    
}
