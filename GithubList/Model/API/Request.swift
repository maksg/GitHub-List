//
//  Request.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

enum RequestError: String, Error {
    case invalidURL
}

class Request: RequestProtocol {
    
    // MARK: Properties
    
    private let apiURL: String
    private let endpoint: Endpoint
    
    // MARK: RequestProtocol - Initialization
    
    required init(withURL apiUrl: String, forEndpoint endpoint: Endpoint) {
        self.apiURL = apiUrl
        self.endpoint = endpoint
    }
    
    // MARK: Private Methods
    
    private func getRequest(withURL apiUrl: String, forEndpoint endpoint: Endpoint) throws -> URLRequest {
        let method = endpoint.method
        let parameters = endpoint.parameters
        var headers = endpoint.headers
        headers["Content-Type"] = "application/json"
        
        let urlString = apiURL + endpoint.path
        var urlComponents = URLComponents(string: urlString)
        
        if method == .get {
            if parameters.count > 0 {
                urlComponents?.queryItems = parameters.map({ URLQueryItem(name: $0.key, value: String(describing: $0.value)) })
            }
        }
        
        guard let url = urlComponents?.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        request.cachePolicy = .returnCacheDataElseLoad
        
        print(url.absoluteString)
        print(headers)
        print(parameters)
        
        return request
    }
    
    // MARK: Methods
    
    func makeRequest(completionHandler: @escaping (Error?) -> Void) {
        let request: URLRequest
        do {
            request = try getRequest(withURL: self.apiURL, forEndpoint: self.endpoint)
        }
        catch {
            completionHandler(error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
            DispatchQueue.main.async {
                completionHandler(error)
            }
        }
        
        task.resume()
    }
    
    func makeRequest<ResponseData: ResponseDataProtocol>(completionHandler: @escaping (ResponseData?, Error?) -> Void) {
        let request: URLRequest
        do {
            request = try getRequest(withURL: self.apiURL, forEndpoint: self.endpoint)
        }
        catch {
            completionHandler(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
            else {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(formatter)
                        
                        let responseData = try decoder.decode(ResponseData.self, from: data)
                        DispatchQueue.main.async {
                            completionHandler(responseData, nil)
                        }
                    }
                    catch {
                        print(error)
                        DispatchQueue.main.async {
                            completionHandler(nil, error)
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completionHandler(nil, nil)
                    }
                }
            }
        }
        
        task.resume()
    }
    
}
