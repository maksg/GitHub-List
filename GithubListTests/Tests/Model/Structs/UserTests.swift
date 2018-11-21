//
//  UserTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class UserTests: XCTestCase {
    
    var user: User!
    var user2: User!

    override func setUp() {
        super.setUp()
        
        self.user = User(id: 1, login: "login", avatarUrl: "avatarUrl", publicRepositories: 10)
        self.user2 = User(id: -100, login: "", avatarUrl: "", publicRepositories: nil)
    }

    override func tearDown() {
        self.user = nil
        self.user2 = nil
        
        super.tearDown()
    }

    func testId() {
        XCTAssertEqual(self.user.id, 1)
        XCTAssertNotEqual(self.user2.id, 1)
    }
    
    func testLogin() {
        XCTAssertEqual(self.user.login, "login")
        XCTAssertNotEqual(self.user2.login, "login")
    }
    
    func testAvatarUrl() {
        XCTAssertEqual(self.user.avatarUrl, "avatarUrl")
        XCTAssertNotEqual(self.user2.avatarUrl, "avatarUrl")
    }
    
    func testPublicRepositories() {
        XCTAssertEqual(self.user.publicRepositories, 10)
        XCTAssertNotEqual(self.user2.publicRepositories, 10)
        XCTAssertNotNil(self.user.publicRepositories)
        XCTAssertNil(self.user2.publicRepositories)
    }
    
    func testCodingKeys() {
        XCTAssertEqual(User.CodingKeys.id.rawValue, "id")
        XCTAssertEqual(User.CodingKeys.login.rawValue, "login")
        XCTAssertEqual(User.CodingKeys.avatarUrl.rawValue, "avatar_url")
        XCTAssertEqual(User.CodingKeys.publicRepositories.rawValue, "public_repos")
    }

}
