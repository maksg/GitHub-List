//
//  Request.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

enum RequestError: Error, LocalizedError {
    case invalidUrl
    case invalidEndpoint
    
    public var errorDescription: String? {
        get {
            switch self {
            case .invalidUrl:
                return Translation.Error.invalidUrl.localized
            case .invalidEndpoint:
                return Translation.Error.invalidEndpoint.localized
            }
        }
    }
}

class Request: RequestProtocol {
    
    // MARK: Properties
    
    let apiURL: String
    var endpoint: Endpoint!
    
    // MARK: RequestProtocol - Initialization
    
    required init(withURL apiUrl: String) {
        self.apiURL = apiUrl
    }
    
    // MARK: Methods
    
    func getRequest() throws -> URLRequest {
        guard endpoint != nil else {
            throw RequestError.invalidEndpoint
        }
        
        let method = self.endpoint.method
        let parameters = self.endpoint.parameters
        var headers = self.endpoint.headers
        headers["Content-Type"] = "application/json"
        
        var urlComponents = URLComponents(string: apiURL)
        urlComponents?.path = endpoint.path
        
        if method == .get {
            if parameters.count > 0 {
                urlComponents?.queryItems = parameters.map({ URLQueryItem(name: $0.key, value: String(describing: $0.value)) })
            }
        }
        
        guard let url = urlComponents?.url else {
            throw RequestError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        request.cachePolicy = .returnCacheDataElseLoad
        
        return request
    }
    
    func makeRequest(completionHandler: @escaping (Error?) -> Void) {
        let request: URLRequest
        do {
            request = try self.getRequest()
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
            request = try self.getRequest()
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
