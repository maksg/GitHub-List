//
//  UsersTableViewCell.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell, View {
    
    // MARK: View - Properties
    
    typealias ViewModelType = UsersCellViewModel
    var viewModel: UsersCellViewModel! {
        didSet {
            self.avatarImageView.injector = self.viewModel.injector
            self.avatarImageView.imageUrl = self.viewModel.avatarUrl
            self.loginLabel.text = self.viewModel.login
            self.repositoriesLabel.text = self.viewModel.repositories
        }
    }
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var avatarImageView: DownloadableImageView!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var repositoriesLabel: UILabel!
    
    // MARK: UINib

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
