//
//  UIViewControllerExtensions.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 08/10/21.
//

import UIKit

// MARK: - Present alert error function
extension UIViewController {
    func presentErrorAlertWith(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
}
