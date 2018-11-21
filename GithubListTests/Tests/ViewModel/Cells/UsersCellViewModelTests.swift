//
//  UsersCellViewModelTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class UsersCellViewModelTests: XCTestCase {
    
    var injector: InjectorMock!
    var user: User!
    
    var viewModel: UsersCellViewModel!
    var viewModelWithUser: UsersCellViewModel!

    override func setUp() {
        super.setUp()
        
        let request = RequestMock(withURL: "http://apple.com/")
        let apiRequest = APIRequestMock(withRequest: request)
        let imageCache = NSCache<AnyObject, AnyObject>()
        self.injector = InjectorMock(withApiRequest: apiRequest, andImageCache: imageCache)
        self.viewModel = UsersCellViewModel(withInjector: self.injector)
        
        self.user = User(id: 1, login: "login", avatarUrl: "avatarUrl", publicRepositories: 10)
        self.viewModelWithUser = UsersCellViewModel(withInjector: self.injector, andUser: self.user)
    }

    override func tearDown() {
        self.viewModel = nil
        self.viewModelWithUser = nil
        
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertTrue(self.viewModel.injector as? InjectorMock === self.injector)
        XCTAssertNil(self.viewModel.user)
        
        XCTAssertTrue(self.viewModelWithUser.injector as? InjectorMock === self.injector)
        XCTAssertEqual(self.viewModelWithUser.user, self.user)
    }
    
    func testAvatarUrl() {
        XCTAssertEqual(self.viewModel.avatarUrl, "")
        XCTAssertEqual(self.viewModelWithUser.avatarUrl, "avatarUrl")
    }
    
    func testLogin() {
        XCTAssertNil(self.viewModel.login)
        XCTAssertEqual(self.viewModelWithUser.login, "login")
    }
    
    func testRepositories() {
        XCTAssertNil(self.viewModel.repositories)
        let text = Translation.Users.publicRepositories.localized
        XCTAssertEqual(self.viewModelWithUser.repositories, "\(text): 10")
        
        self.user.publicRepositories = nil
        let viewModelWithUserNil = UsersCellViewModel(withInjector: self.injector, andUser: self.user)
        XCTAssertNil(viewModelWithUserNil.repositories)
    }

}
