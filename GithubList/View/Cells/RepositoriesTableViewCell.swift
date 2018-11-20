//
//  RepositoriesTableViewCell.swift
//  GithubList
//
//  Created by Maksymilian Galas on 19/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell, View {
    
    // MARK: View - Properties
    
    typealias ViewModelType = RepositoriesCellViewModel
    var viewModel: RepositoriesCellViewModel! {
        didSet {
            self.nameLabel.text = self.viewModel.fullName
            self.createdDateLabel.text = self.viewModel.createdDate
            self.updatedDateLabel.text = self.viewModel.updatedDate
        }
    }
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var createdDateLabel: UILabel!
    @IBOutlet private weak var updatedDateLabel: UILabel!
    
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
