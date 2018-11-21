//
//  RepositoryTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class RepositoryTests: XCTestCase {
    
    var repository: Repository!
    var repository2: Repository!
    
    var today: Date!
    
    override func setUp() {
        super.setUp()
        
        self.today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        let url = URL(string: "http://apple.com/")!
        let url2 = URL(string: "http://microsoft.com/")!
        
        self.repository = Repository(id: 1, fullName: "fullName", createdDate: today, updatedDate: today, url: url)
        self.repository2 = Repository(id: -100, fullName: "", createdDate: yesterday, updatedDate: yesterday, url: url2)
    }
    
    override func tearDown() {
        self.repository = nil
        self.repository2 = nil
        
        super.tearDown()
    }
    
    func testId() {
        XCTAssertEqual(self.repository.id, 1)
        XCTAssertNotEqual(self.repository2.id, 1)
    }
    
    func testFullName() {
        XCTAssertEqual(self.repository.fullName, "fullName")
        XCTAssertNotEqual(self.repository2.fullName, "fullName")
    }
    
    func testCreatedDate() {
        XCTAssertEqual(self.repository.createdDate, today)
        XCTAssertNotEqual(self.repository2.createdDate, today)
    }
    
    func testUpdatedDate() {
        XCTAssertEqual(self.repository.updatedDate, today)
        XCTAssertNotEqual(self.repository2.updatedDate, today)
    }
    
    func testUrl() {
        XCTAssertEqual(self.repository.url.absoluteString, "http://apple.com/")
        XCTAssertNotEqual(self.repository2.url.absoluteString, "http://apple.com/")
    }
    
    func testCodingKeys() {
        XCTAssertEqual(Repository.CodingKeys.id.rawValue, "id")
        XCTAssertEqual(Repository.CodingKeys.fullName.rawValue, "full_name")
        XCTAssertEqual(Repository.CodingKeys.createdDate.rawValue, "created_at")
        XCTAssertEqual(Repository.CodingKeys.updatedDate.rawValue, "updated_at")
        XCTAssertEqual(Repository.CodingKeys.url.rawValue, "html_url")
    }

}
