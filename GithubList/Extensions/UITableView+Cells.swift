//
//  UITableView+Cells.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

extension UITableView {
    
    open func register(_ cellClass: Swift.AnyClass?) {
        if let cellClass = cellClass {
            let reuseIdentifier = String(describing: type(of: cellClass)).components(separatedBy: ".").first!
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            self.register(nib, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<Type: UITableViewCell>(forClass cellClass: Type.Type, for indexPath: IndexPath) -> Type {
        let name = String(describing: type(of: cellClass)).components(separatedBy: ".").first!
        return self.dequeueReusableCell(withIdentifier: name, for: indexPath) as! Type
    }
    
    open func registerReusableHeaderFooterView(_ cellClass: Swift.AnyClass?) {
        if let cellClass = cellClass {
            let reuseIdentifier = String(describing: type(of: cellClass)).components(separatedBy: ".").first!
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            self.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
    }
    
    func dequeueReusableHeaderFooterView<Type: UIView>(forClass cellClass: Type.Type)  -> Type {
        let name = String(describing: type(of: cellClass)).components(separatedBy: ".").first!
        return self.dequeueReusableHeaderFooterView(withIdentifier: name) as! Type
    }
    
}
