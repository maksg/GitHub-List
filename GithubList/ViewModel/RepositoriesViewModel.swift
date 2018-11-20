//
//  RepositoriesViewModel.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

protocol RepositoriesViewModelDelegate: class {
    func repositoriesViewModel(_ viewModel: RepositoriesViewModel, didGetRepositoriesWithError error: Error?)
}

class RepositoriesViewModel: ViewModel {
    
    // MARK: ViewModel - Properties
    
    let injector: InjectorProtocol?
    
    // MARK: Private - Properties
    
    private var downloadingData: Bool
    
    private var currentPage: Int
    
    // MARK: Private(set) - Properties
    
    private(set) var user: User?
    
    private(set) var repositories: [Repository]
    
    // MARK: Properties
    
    var repositoryViewModels: [RepositoriesCellViewModel]
    
    weak var delegate: RepositoriesViewModelDelegate?
    
    // MARK: ViewModel - Initialization
    
    required init(withInjector injector: InjectorProtocol) {
        self.injector = injector
        self.repositories = []
        self.repositoryViewModels = []
        self.downloadingData = false
        self.currentPage = 1
    }
    
    // MARK: Initialization
    
    convenience init(withInjector injector: InjectorProtocol, andUser user: User) {
        self.init(withInjector: injector)
        
        self.user = user
    }
    
    // MARK: Methods
    
    func getRepositories(fullRefresh: Bool = true) {
        guard let userLogin = self.user?.login, self.downloadingData == false else {
            return
        }
        
        if fullRefresh {
            self.currentPage = 1
        }
        
        guard self.currentPage != -1 else {
            return
        }
        
        self.downloadingData = true
        
        self.injector?.apiRequest.getRepositories(userLogin: userLogin, page: self.currentPage, completionHandler: { [weak self] (repositories, error) in
            self?.downloadingData = false
            
            guard let `self` = self else {
                return
            }
            
            if let error = error {
                self.delegate?.repositoriesViewModel(self, didGetRepositoriesWithError: error)
            }
            else {
                self.currentPage += 1
                
                let repositories = repositories ?? []
                
                if fullRefresh {
                    self.repositories = []
                } else if repositories.count == 0 {
                    self.currentPage = -1
                    return
                }
                self.repositories += repositories
                
                self.repositoryViewModels = self.repositories.map {
                    RepositoriesCellViewModel(withRepository: $0)
                }
                
                self.delegate?.repositoriesViewModel(self, didGetRepositoriesWithError: nil)
            }
        })
    }
    
}
