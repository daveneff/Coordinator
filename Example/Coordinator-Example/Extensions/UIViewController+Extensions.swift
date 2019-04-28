//  UIViewController+Extensions.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

extension UIViewController {
    
    /** Convenience method for presenting a simple `UIAlertController`. */
    
    func showAlert(title: String, message: String, actionTitle: String, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            handler?()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
}
