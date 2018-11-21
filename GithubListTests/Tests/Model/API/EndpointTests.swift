//
//  EndpointTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class EndpointTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetUsers() {
        let endpoint = Endpoint.getUsers(sinceId: nil)
        XCTAssertEqual(endpoint.headers, [:])
        XCTAssertEqual(endpoint.parameters.count, 0)
        XCTAssertEqual(endpoint.path, "/users")
        XCTAssertEqual(endpoint.method, .get)
    }

    func testGetUsersWithSinceId() {
        let id = "id"
        let endpoint = Endpoint.getUsers(sinceId: id)
        XCTAssertEqual(endpoint.headers, [:])
        XCTAssertEqual(endpoint.parameters.count, 1)
        XCTAssertEqual(endpoint.parameters["since"] as? String, id)
        XCTAssertEqual(endpoint.path, "/users")
        XCTAssertEqual(endpoint.method, .get)
    }
    
    func testGetUser() {
        let login = "login"
        let endpoint = Endpoint.getUser(login: login)
        XCTAssertEqual(endpoint.headers, [:])
        XCTAssertEqual(endpoint.parameters.count, 0)
        XCTAssertEqual(endpoint.path, "/users/\(login)")
        XCTAssertEqual(endpoint.method, .get)
    }
    
    func testGetRepositories() {
        let login = "login"
        let page = 2
        let endpoint = Endpoint.getRepositories(login: login, page: page)
        XCTAssertEqual(endpoint.headers, [:])
        XCTAssertEqual(endpoint.parameters.count, 3)
        XCTAssertEqual(endpoint.parameters["type"] as? String, "all")
        XCTAssertEqual(endpoint.parameters["per_page"] as? Int, 100)
        XCTAssertEqual(endpoint.parameters["page"] as? Int, page)
        XCTAssertEqual(endpoint.path, "/users/\(login)/repos")
        XCTAssertEqual(endpoint.method, .get)
    }

}
