//
//  RequestTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class RequestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestThrows() {
        let request = Request(withURL: "...\\")
        XCTAssertEqual(request.apiURL, "...\\")
        
        XCTAssertNil(request.endpoint)
        XCTAssertThrowsError(try request.getRequest(), "") { (error) in
            let error = error as? RequestError
            XCTAssertNotNil(error)
            XCTAssertEqual(error, RequestError.invalidEndpoint)
        }
        
        request.endpoint = .getUsers(sinceId: "id")
        XCTAssertNotNil(request.endpoint)
        XCTAssertThrowsError(try request.getRequest(), "") { (error) in
            let error = error as? RequestError
            XCTAssertNotNil(error)
            XCTAssertEqual(error, RequestError.invalidUrl)
        }
    }
    
    func testRequestForGetUsers() {
        let url = "http://getusers.com"
        let endpoint = Endpoint.getUsers(sinceId: nil)
        let request = Request(withURL: url)
        request.endpoint = endpoint
        let urlRequest = try! request.getRequest()
        
        XCTAssertEqual(request.apiURL, url)
        XCTAssertEqual(request.endpoint, endpoint)
        XCTAssertEqual(urlRequest.url?.absoluteString, "\(url)/users")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type" : "application/json"])
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.cachePolicy, .returnCacheDataElseLoad)
    }
    
    func testRequestForGetUsersWithSinceId() {
        let url = "http://getusers.com"
        let id = "id"
        let endpoint = Endpoint.getUsers(sinceId: id)
        let request = Request(withURL: url)
        request.endpoint = endpoint
        let urlRequest = try! request.getRequest()
        
        XCTAssertEqual(request.apiURL, url)
        XCTAssertEqual(request.endpoint, endpoint)
        XCTAssertEqual(urlRequest.url?.absoluteString, "\(url)/users?since=\(id)")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type" : "application/json"])
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.cachePolicy, .returnCacheDataElseLoad)
    }
    
    func testRequestForGetUser() {
        let url = "http://getuser.com"
        let login = "login"
        let endpoint = Endpoint.getUser(login: login)
        let request = Request(withURL: url)
        request.endpoint = endpoint
        let urlRequest = try! request.getRequest()
        
        XCTAssertEqual(request.apiURL, url)
        XCTAssertEqual(request.endpoint, endpoint)
        XCTAssertEqual(urlRequest.url?.absoluteString, "\(url)/users/\(login)")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type" : "application/json"])
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.cachePolicy, .returnCacheDataElseLoad)
    }
    
    func testRequestForGetRepositories() {
        let url = "http://getrepositories.com"
        let login = "login"
        let page = 2
        let endpoint = Endpoint.getRepositories(login: login, page: page)
        let request = Request(withURL: url)
        request.endpoint = endpoint
        let urlRequest = try! request.getRequest()
        
        XCTAssertEqual(request.apiURL, url)
        XCTAssertEqual(request.endpoint, endpoint)
        
        let urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: true)
//        XCTAssertEqual(urlRequest.url?.absoluteString, "\(url)/users/\(login)/repos?type=all&per_page=100&page=\(page)")
        XCTAssertEqual(urlComponents?.queryItems?.count, 3)
        XCTAssertTrue(urlComponents?.queryItems?.contains(URLQueryItem(name: "type", value: "all")) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(URLQueryItem(name: "per_page", value: "100")) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(URLQueryItem(name: "page", value: "\(page)")) ?? false)
        XCTAssertEqual(urlComponents?.scheme, "http")
        XCTAssertEqual(urlComponents?.host, "getrepositories.com")
        XCTAssertEqual(urlComponents?.path, "/users/\(login)/repos")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type" : "application/json"])
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.cachePolicy, .returnCacheDataElseLoad)
    }

}
