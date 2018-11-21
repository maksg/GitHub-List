//
//  RepositoriesCellViewModelTests.swift
//  GithubListTests
//
//  Created by Maksymilian Galas on 21/11/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import XCTest
@testable import GithubList

class RepositoriesCellViewModelTests: XCTestCase {
    
    var injector: InjectorMock!
    var repository: Repository!
    var date: Date!
    
    var viewModel: RepositoriesCellViewModel!
    var viewModelWithRepository: RepositoriesCellViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.date = Date()
        
        let request = RequestMock(withURL: "http://apple.com/")
        let apiRequest = APIRequestMock(withRequest: request)
        let imageCache = NSCache<AnyObject, AnyObject>()
        self.injector = InjectorMock(withApiRequest: apiRequest, andImageCache: imageCache)
        self.viewModel = RepositoriesCellViewModel(withInjector: self.injector)
        
        self.repository = Repository(id: 1, fullName: "fullName", createdDate: self.date, updatedDate: self.date, url: URL(string: "http://apple.com/")!)
        self.viewModelWithRepository = RepositoriesCellViewModel(withInjector: self.injector, andRepository: self.repository)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.viewModelWithRepository = nil
        
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertTrue(self.viewModel.injector as? InjectorMock === self.injector)
        XCTAssertNil(self.viewModel.repository)
        
        XCTAssertTrue(self.viewModelWithRepository.injector as? InjectorMock === self.injector)
        XCTAssertEqual(self.viewModelWithRepository.repository, self.repository)
    }
    
    func testFullName() {
        XCTAssertNil(self.viewModel.fullName)
        XCTAssertEqual(self.viewModelWithRepository.fullName, "fullName")
    }
    
    func testUrl() {
        XCTAssertNil(self.viewModel.url)
        XCTAssertEqual(self.viewModelWithRepository.url?.absoluteString, "http://apple.com/")
    }
    
    func testCreatedDate() {
        XCTAssertNil(self.viewModel.createdDate)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        let dateString = formatter.string(from: self.date)
        
        let text = Translation.Repositories.createdAt.localized
        XCTAssertEqual(self.viewModelWithRepository.createdDate, "\(text) \(dateString)")
    }
    
    func testUpdatedDate() {
        XCTAssertNil(self.viewModel.updatedDate)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        let dateString = formatter.string(from: self.date)
        
        let text = Translation.Repositories.updatedAt.localized
        XCTAssertEqual(self.viewModelWithRepository.updatedDate, "\(text) \(dateString)")
    }

}
