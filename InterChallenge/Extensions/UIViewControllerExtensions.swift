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

extension UITableViewCell {
    func makeGenericUIViewWith(backgroundColor: UIColor) -> UIView {
        let newView = UIView()
        newView.backgroundColor = backgroundColor
        //newView.isOpaque = true
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        return newView
    }
    
    func makeGenericUILabelView(withFontSize size: CGFloat = 17, lines: Int = 1) -> UILabel {
        let labelView = UILabel()
        labelView.font = .systemFont(ofSize: size)
        labelView.numberOfLines = lines
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        return labelView
    }
    
    func makeStackButtonWith(title: String, andSelector selector: Selector) -> UIButton {
        let buttonView = UIButton()
        buttonView.addTarget(self, action: selector, for: .touchUpInside)
        buttonView.setTitle(title, for: .normal)
        buttonView.setTitleColor(.systemOrange, for: .normal)
        buttonView.titleLabel?.font = .systemFont(ofSize: 15)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonView
    }
}
