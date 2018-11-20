//
//  UIKeyboardNotifier.swift
//  GithubList
//
//  Created by Maksymilian Galas on 18/10/2018.
//  Copyright © 2018 Infinity Pi Ltd. All rights reserved.
//

import UIKit

class UIKeyboardNotifier {
    
    private let notificationCenter: NotificationCenter
    private weak var scrollView: UIScrollView?
    private weak var view: UIView?
    
    init(withNotificationCenter notificationCenter: NotificationCenter = NotificationCenter.default, forNotifier notifier: Notifier) {
        self.notificationCenter = notificationCenter
        self.scrollView = notifier.scrollView
        self.view = notifier.view
        
        self.notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        self.notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        self.notificationCenter.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        self.notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let view = self.view, let scrollView = self.scrollView else {
            return
        }
        
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let scrollView = self.scrollView else {
            return
        }
        
        let contentInset: UIEdgeInsets = .zero
        scrollView.contentInset = contentInset
    }
    
}
