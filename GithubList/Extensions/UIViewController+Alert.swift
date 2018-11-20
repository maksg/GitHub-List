//
//  UIViewController+Alert.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, action: String, callback: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { (action) in
            callback?()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(withError error: Error) {
        DispatchQueue.main.async {
            let title: String
            if error is GithubWarning {
                title = Translation.Warning.title.localized
            } else {
                title = Translation.Error.title.localized
            }
            
//            let message = Translation.Error.default.localized
            let message = error.localizedDescription
            let action = Translation.Alert.confirm.localized
            self.showAlert(title: title, message: message, action: action, callback: nil)
        }
    }
    
}
