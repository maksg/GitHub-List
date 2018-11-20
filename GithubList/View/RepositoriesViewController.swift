//
//  RepositoriesViewController.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController, View, UITableViewDataSource, UITableViewDelegate, RepositoriesViewModelDelegate {
    
    // MARK: View - Properties
    
    typealias ViewModelType = RepositoriesViewModel
    var viewModel: RepositoriesViewModel!
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Translation.Repositories.title.localized
        
        self.viewModel.delegate = self
        
        self.tableView.register(RepositoriesTableViewCell.self)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(downloadRepositories), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.getRepositories()
    }
    
    // MARK: Private Methods
    
    @objc private func downloadRepositories() {
        self.viewModel.getRepositories()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repositoryViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.repositoryViewModels[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(forClass: RepositoriesTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.presentedViewController == nil else {
            return
        }
        
        if indexPath.row == self.viewModel.repositoryViewModels.count - 1 {
            self.viewModel.getRepositories(fullRefresh: false)
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewModel = self.viewModel.repositoryViewModels[indexPath.row]
        if let url = viewModel.url {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // MARK: RepositoriesViewModelDelegate
    
    func repositoriesViewModel(_ viewModel: RepositoriesViewModel, didGetRepositoriesWithError error: Error?) {
        if let error = error {
            self.showAlert(withError: error)
        }
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
}
