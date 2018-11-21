//
//  UsersViewController.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, View, UITableViewDataSource, UITableViewDelegate, UsersViewModelDelegate {
    
    // MARK: View - Properties
    
    typealias ViewModelType = UsersViewModel
    var viewModel: UsersViewModel!
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Translation.Users.title.localized
        
        self.viewModel.delegate = self
        
        self.tableView.register(UsersTableViewCell.self)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(downloadUsers), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        self.viewModel.getUsers()
    }
    
    // MARK: Private Methods
    
    @objc private func downloadUsers() {
        self.viewModel.getUsers()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.userViewModels[indexPath.row]

        let cell = tableView.dequeueReusableCell(forClass: UsersTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? UsersTableViewCell else {
            return
        }
        
        if cell.viewModel.repositories == nil {
            if let user = cell.viewModel.user {
                self.viewModel.getUser(user)
            }
        }
        
        guard self.presentedViewController == nil else {
            return
        }
        
        let usersCount = self.viewModel.userViewModels.count
        if usersCount >= 80 && !self.viewModel.didShowWarning {
            self.viewModel.warningWasShown()
            self.showAlert(withError: GithubWarning.requestLimit)
        }
        else if indexPath.row == usersCount - 1 {
            self.viewModel.getUsers(sinceUserViewModel: cell.viewModel)
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewModel = self.viewModel.userViewModels[indexPath.row]
        self.performSegue(withIdentifier: "RepositoriesSegue", sender: viewModel)
    }
    
    // MARK: Prepare For Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reposVC = segue.destination as? RepositoriesViewController {
            if let user = (sender as? UsersCellViewModel)?.user {
                reposVC.viewModel = RepositoriesViewModel(withInjector: self.viewModel.injector, andUser: user)
            }
        }
    }
    
    // MARK: UsersViewModelDelegate
    
    func usersViewModel(_ viewModel: UsersViewModel, didGetUserWithIndex userIndex: Int?, withError error: Error?) {
        if let error = error {
            self.showAlert(withError: error)
            return
        }
        
        guard let row = userIndex else { return }
        let indexPath = IndexPath(row: row, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func usersViewModel(_ viewModel: UsersViewModel, didGetUsersWithError error: Error?) {
        if let error = error {
            self.showAlert(withError: error)
        }
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
}
