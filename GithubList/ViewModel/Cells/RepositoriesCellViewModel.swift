//
//  RepositoriesCellViewModel.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class RepositoriesCellViewModel: ViewModel {
    
    // MARK: ViewModel - Properties
    
    var injector: InjectorProtocol
    
    // MARK: Properties
    
    var fullName: String? {
        get {
            return self.repository?.fullName
        }
    }
    
    var createdDate: String? {
        get {
            if let date = self.repository?.createdDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.timeStyle = .medium
                let dateString = formatter.string(from: date)
                
                let text = Translation.Repositories.createdAt.localized
                return "\(text) \(dateString)"
            }
            return nil
        }
    }
    
    var updatedDate: String? {
        get {
            if let date = self.repository?.updatedDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.timeStyle = .medium
                let dateString = formatter.string(from: date)
                
                let text = Translation.Repositories.updatedAt.localized
                return "\(text) \(dateString)"
            }
            return nil
        }
    }
    
    var url: URL? {
        get {
            return self.repository?.url
        }
    }
    
    // MARK: Private(set) - Properties
    
    private(set) var repository: Repository?
    
    // MARK: ViewModel - Initialization
    
    required init(withInjector injector: InjectorProtocol) {
        self.injector = injector
    }
    
    // MARK: Initialization
    
    convenience init(withInjector injector: InjectorProtocol, andRepository repository: Repository) {
        self.init(withInjector: injector)
        self.repository = repository
    }
    
}
