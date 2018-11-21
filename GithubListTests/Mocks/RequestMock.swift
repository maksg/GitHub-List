//
//  RequestMock.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class RequestMock: RequestProtocol {
    
    // MARK: Properties
    
    let apiURL: String
    var endpoint: Endpoint!
    
    var responseData: ResponseDataProtocol?
    
    // MARK: RequestProtocol - Initialization
    
    required init(withURL apiUrl: String) {
        self.apiURL = apiUrl
    }
    
    // MARK: Methods
    
    func getRequest() throws -> URLRequest {
        let url = URL(string: "http://apple.com/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
    
    func makeRequest(completionHandler: @escaping (Error?) -> Void) {
        completionHandler(nil)
    }
    
    func makeRequest<ResponseData: ResponseDataProtocol>(completionHandler: @escaping (ResponseData?, Error?) -> Void) {
        if let responseData = responseData as? ResponseData {
            completionHandler(responseData, nil)
        } else {
            completionHandler(nil, nil)
        }
    }
    
}
