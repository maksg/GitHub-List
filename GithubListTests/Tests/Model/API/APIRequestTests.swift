//
//  APIRequestTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class APIRequestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetUser() {
        let user = User(id: 1, login: "login", avatarUrl: "avatarUrl", publicRepositories: 10)
        let request = RequestMock(withURL: "http://apple.com/")
        request.responseData = user
        let apiRequest = APIRequest(withRequest: request)
        apiRequest.getUser(login: "login") { (responseData, error) in
            XCTAssertEqual(responseData, user)
            XCTAssertNil(error)
        }
    }
    
    func testGetUsers() {
        let users = [User(id: 1, login: "login", avatarUrl: "avatarUrl", publicRepositories: 10), User(id: 2, login: "login2", avatarUrl: "avatarUrl2", publicRepositories: nil)]
        let request = RequestMock(withURL: "http://apple.com/")
        request.responseData = users
        let apiRequest = APIRequest(withRequest: request)
        apiRequest.getUsers(sinceId: nil) { (responseData, error) in
            XCTAssertEqual(responseData, users)
            XCTAssertNil(error)
        }
    }
    
    func testGetRepositories() {
        let repositories = [Repository(id: 1, fullName: "fullName", createdDate: Date(), updatedDate: Date(), url: URL(string: "http://apple.com/")!)]
        let request = RequestMock(withURL: "http://apple.com/")
        request.responseData = repositories
        let apiRequest = APIRequest(withRequest: request)
        apiRequest.getRepositories(userLogin: "login", page: 2) { (responseData, error) in
            XCTAssertEqual(responseData, repositories)
            XCTAssertNil(error)
        }
    }

}
