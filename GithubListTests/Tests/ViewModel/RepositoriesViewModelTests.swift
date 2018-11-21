//
//  RepositoriesViewModelTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class RepositoriesViewModelTests: XCTestCase {
    
    var injector: InjectorMock!
    var user: User!
    var repositories: [Repository]!
    
    var viewModel: RepositoriesViewModel!
    var viewModelWithUser: RepositoriesViewModel!
    
    override func setUp() {
        super.setUp()
        
        let date = Date()
        self.repositories = [
            Repository(id: 1, fullName: "fullName", createdDate: date, updatedDate: date, url: URL(string: "http://apple.com/")!),
            Repository(id: -10, fullName: "", createdDate: date, updatedDate: date, url: URL(string: "http://microsoft.com/")!)
        ]
        
        let request = RequestMock(withURL: "http://apple.com/")
        request.responseData = self.repositories
        let apiRequest = APIRequestMock(withRequest: request)
        let imageCache = NSCache<AnyObject, AnyObject>()
        self.injector = InjectorMock(withApiRequest: apiRequest, andImageCache: imageCache)
        self.viewModel = RepositoriesViewModel(withInjector: self.injector)
        
        self.user = User(id: 1, login: "login", avatarUrl: "avatarUrl", publicRepositories: 10)
        self.viewModelWithUser = RepositoriesViewModel(withInjector: self.injector, andUser: self.user)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.viewModelWithUser = nil
        
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertTrue(self.viewModel.injector as? InjectorMock === self.injector)
        XCTAssertNil(self.viewModel.user)
        XCTAssertEqual(self.viewModel.repositories.count, 0)
        XCTAssertEqual(self.viewModel.repositoryViewModels.count, 0)
        XCTAssertNil(self.viewModel.delegate)
        XCTAssertFalse(self.viewModel.downloadingData)
        XCTAssertEqual(self.viewModel.currentPage, 1)
        
        XCTAssertTrue(self.viewModelWithUser.injector as? InjectorMock === self.injector)
        XCTAssertEqual(self.viewModelWithUser.user, self.user)
        XCTAssertEqual(self.viewModelWithUser.repositories.count, 0)
        XCTAssertEqual(self.viewModelWithUser.repositoryViewModels.count, 0)
        XCTAssertNil(self.viewModelWithUser.delegate)
        XCTAssertFalse(self.viewModelWithUser.downloadingData)
        XCTAssertEqual(self.viewModelWithUser.currentPage, 1)
    }
    
    func testGetRepositories() {
        // Empty View Model
        
        XCTAssertEqual(self.viewModel.repositories.count, 0)
        XCTAssertEqual(self.viewModel.repositoryViewModels.count, 0)
        
        self.viewModel.getRepositories()
        XCTAssertEqual(self.viewModel.repositories.count, 0)
        XCTAssertEqual(self.viewModel.repositoryViewModels.count, 0)
        
        // View Model With User
        
        XCTAssertEqual(self.viewModelWithUser.repositories.count, 0)
        XCTAssertEqual(self.viewModelWithUser.repositoryViewModels.count, 0)
        
        self.viewModelWithUser.getRepositories()
        XCTAssertEqual(self.viewModelWithUser.repositories, self.repositories)
        XCTAssertEqual(self.viewModelWithUser.repositoryViewModels.count, 2)
        
        self.viewModelWithUser.getRepositories(fullRefresh: false)
        XCTAssertEqual(self.viewModelWithUser.repositories, self.repositories + self.repositories)
        XCTAssertEqual(self.viewModelWithUser.repositoryViewModels.count, 4)
        
        self.viewModelWithUser.getRepositories()
        XCTAssertEqual(self.viewModelWithUser.repositories, self.repositories)
        XCTAssertEqual(self.viewModelWithUser.repositoryViewModels.count, 2)
    }

}
