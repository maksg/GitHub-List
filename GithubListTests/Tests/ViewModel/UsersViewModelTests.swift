//
//  UsersViewModelTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 22/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class UsersViewModelTests: XCTestCase {
    
    var injector: InjectorMock!
    var users: [User]!
    
    var viewModel: UsersViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.users = [
            User(id: 1, login: "login", avatarUrl: "avatarUrl", publicRepositories: 10),
            User(id: -10, login: "a", avatarUrl: "a", publicRepositories: nil)
        ]
        
        let request = RequestMock(withURL: "http://apple.com/")
        request.responseData = self.users
        let apiRequest = APIRequestMock(withRequest: request)
        let imageCache = NSCache<AnyObject, AnyObject>()
        self.injector = InjectorMock(withApiRequest: apiRequest, andImageCache: imageCache)
        self.viewModel = UsersViewModel(withInjector: self.injector)
    }
    
    override func tearDown() {
        self.viewModel = nil
        
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertTrue(self.viewModel.injector as? InjectorMock === self.injector)
        XCTAssertEqual(self.viewModel.users.count, 0)
        XCTAssertEqual(self.viewModel.userViewModels.count, 0)
        XCTAssertNil(self.viewModel.delegate)
        XCTAssertFalse(self.viewModel.downloadingData)
        XCTAssertFalse(self.viewModel.didShowWarning)
    }
    
    func testWarningWasShown() {
        XCTAssertFalse(self.viewModel.didShowWarning)
        self.viewModel.warningWasShown()
        XCTAssertTrue(self.viewModel.didShowWarning)
    }
    
    func testGetUsers() {
        XCTAssertEqual(self.viewModel.users.count, 0)
        XCTAssertEqual(self.viewModel.userViewModels.count, 0)

        self.viewModel.getUsers()
        XCTAssertEqual(self.viewModel.users, self.users)
        XCTAssertEqual(self.viewModel.userViewModels.count, 2)
        
        self.viewModel.getUsers(sinceUserViewModel: self.viewModel.userViewModels.last!)
        XCTAssertEqual(self.viewModel.users, self.users + self.users)
        XCTAssertEqual(self.viewModel.userViewModels.count, 4)
        
        self.viewModel.getUsers()
        XCTAssertEqual(self.viewModel.users, self.users)
        XCTAssertEqual(self.viewModel.userViewModels.count, 2)
    }
    
    func testGetUser() {
        self.viewModel.getUsers()
        
        let user = User(id: -10, login: "a", avatarUrl: "a", publicRepositories: 3525)
        let apiRequest = self.viewModel.injector.apiRequest as! APIRequestMock
        let request = apiRequest.request as! RequestMock
        request.responseData = user
        
        XCTAssertNotEqual(self.viewModel.users.last?.publicRepositories, user.publicRepositories)
        self.viewModel.getUser(self.users.last!)
        XCTAssertEqual(self.viewModel.users.last?.publicRepositories, user.publicRepositories)
    }

}
