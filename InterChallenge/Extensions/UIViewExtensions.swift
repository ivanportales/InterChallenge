//
//  UIViewExtensions.swift
//  InterChallenge
//
//  Created by Gonzalo Ivan Santos Portales on 10/10/21.
//

import Foundation
import UIKit

// MARK: - Helper functions to reduce boilerplate of view coding
extension UIView {
    func makeGenericUIViewWith(backgroundColor: UIColor) -> UIView {
        let newView = UIView()
        newView.backgroundColor = backgroundColor
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
