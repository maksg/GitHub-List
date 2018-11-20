//
//  UsersCellViewModel.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

class UsersCellViewModel: ViewModel {
    
    // MARK: ViewModel - Properties
    
    var injector: InjectorProtocol?
    
    // MARK: Properties
    
    var avatarUrl: String {
        get {
            return self.user?.avatarUrl ?? ""
        }
    }
    
    var login: String? {
        get {
            return self.user?.login
        }
    }
    
    var repositories: String? {
        get {
            if let publicRepositories = self.user?.publicRepositories {
                let text = Translation.Users.publicRepositories.localized
                return "\(text): \(publicRepositories)"
            }
            return nil
        }
    }
    
    // MARK: Private(set) - Properties
    
    private(set) var user: User?
    
    // MARK: ViewModel - Initialization
    
    required init(withInjector injector: InjectorProtocol) {
        self.injector = injector
    }
    
    // MARK: Initialization
    
    init(withUser user: User) {
        self.injector = nil
        self.user = user
    }
    
}
