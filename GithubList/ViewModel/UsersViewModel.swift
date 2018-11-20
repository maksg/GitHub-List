//
//  UsersViewModel.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

enum GithubError: Error, LocalizedError {
    case requestLimitReached
    
    public var errorDescription: String? {
        get {
            switch self {
            case .requestLimitReached:
                return Translation.Error.requestLimitReached.localized
            }
        }
    }
}

enum GithubWarning: Error, LocalizedError {
    case requestLimit
    
    public var errorDescription: String? {
        get {
            switch self {
            case .requestLimit:
                return Translation.Warning.requestLimit.localized
            }
        }
    }
}

protocol UsersViewModelDelegate: class {
    func usersViewModel(_ viewModel: UsersViewModel, didGetUserWithIndex userIndex: Int?, withError error: Error?)
    func usersViewModel(_ viewModel: UsersViewModel, didGetUsersWithError error: Error?)
}

class UsersViewModel: ViewModel {
    
    // MARK: ViewModel - Properties
    
    let injector: InjectorProtocol?
    
    // MARK: Private - Properties
    
    private var downloadingData: Bool
    
    // MARK: Private(set) - Properties
    
    private(set) var didShowWarning: Bool
    
    private(set) var users: [User]
    
    // MARK: Properties
    
    var userViewModels: [UsersCellViewModel]
    
    weak var delegate: UsersViewModelDelegate?
    
    // MARK: ViewModel - Initialization
    
    required init(withInjector injector: InjectorProtocol) {
        self.injector = injector
        self.users = []
        self.userViewModels = []
        self.downloadingData = false
        self.didShowWarning = false
    }
    
    // MARK: Methods
    
    func warningWasShown() {
        self.didShowWarning = true
    }
    
    func getUsers(sinceUserViewModel: UsersCellViewModel? = nil) {
        guard self.downloadingData == false else {
            return
        }
        
        let sinceId: String?
        if let id = sinceUserViewModel?.user?.id {
            sinceId = "\(id)"
        } else {
            sinceId = nil
        }
        
        self.downloadingData = true
        
        self.injector?.apiRequest.getUsers(sinceId: sinceId, completionHandler: { [weak self] (users, error) in
            self?.downloadingData = false
            
            guard let `self` = self else {
                return
            }
            
            if let error = error {
                self.delegate?.usersViewModel(self, didGetUsersWithError: error)
            }
            else {
                if sinceId == nil {
                    self.users = []
                }
                
                let users = users ?? []
                self.users += users

                self.userViewModels = self.users.map {
                    UsersCellViewModel(withUser: $0)
                }
                
                self.delegate?.usersViewModel(self, didGetUsersWithError: nil)
            }
        })
    }
    
    func getUser(_ user: User) {
        self.injector?.apiRequest.getUser(login: user.login, completionHandler: { [weak self] (user, error) in
            guard let `self` = self else {
                return
            }
            
            if let user = user, error == nil {
                guard let index = self.users.firstIndex(where: { $0.login == user.login }) else {
                    return
                }
                
                self.users[index] = user
                self.userViewModels[index] = UsersCellViewModel(withUser: user)
                
                self.delegate?.usersViewModel(self, didGetUserWithIndex: index, withError: nil)
            }
            else {
                self.delegate?.usersViewModel(self, didGetUserWithIndex: nil, withError: GithubError.requestLimitReached)
            }
        })
    }
    
}
