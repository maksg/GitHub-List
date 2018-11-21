//
//  View.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

protocol View {
    
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType! {
        get
        set
    }
    
}
