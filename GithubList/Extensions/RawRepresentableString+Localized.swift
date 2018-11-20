//
//  RawRepresentableString+Localized.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue == String {
    
    var localized: String {
        return rawValue.localized
    }
    
}
