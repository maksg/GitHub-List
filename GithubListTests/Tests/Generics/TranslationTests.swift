//
//  TranslationTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class TranslationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlert() {
        XCTAssertEqual(Translation.Alert.confirm.rawValue, "alert_confirm")
        XCTAssertEqual(Translation.Alert.cancel.rawValue, "alert_cancel")
    }
    
    func testError() {
        XCTAssertEqual(Translation.Error.title.rawValue, "error_title")
        XCTAssertEqual(Translation.Error.default.rawValue, "error_default")
        XCTAssertEqual(Translation.Error.requestLimitReached.rawValue, "error_request_limit_reached")
    }
    
    func testWarning() {
        XCTAssertEqual(Translation.Warning.title.rawValue, "warning_title")
        XCTAssertEqual(Translation.Warning.requestLimit.rawValue, "warning_request_limit")
    }
    
    func testUsers() {
        XCTAssertEqual(Translation.Users.title.rawValue, "users_title")
        XCTAssertEqual(Translation.Users.publicRepositories.rawValue, "users_public_repositories")
    }
    
    func testRepositories() {
        XCTAssertEqual(Translation.Repositories.title.rawValue, "repositories_title")
        XCTAssertEqual(Translation.Repositories.createdAt.rawValue, "repositories_created_at")
        XCTAssertEqual(Translation.Repositories.updatedAt.rawValue, "repositories_updated_at")
    }

}
