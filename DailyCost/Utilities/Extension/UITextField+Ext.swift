//
//  UITextField+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

// MARK: - Left Right View
extension UITextField {
    func setLeftView(_ view: UIView, padding: CGFloat = 0) {
        additionalView(view, padding: padding, isLeft: true)
    }
    
    func setRightView(_ view: UIView, padding: CGFloat = 0) {
        additionalView(view, padding: padding, isLeft: false)
    }
    
    private func additionalView(_ view: UIView, padding: CGFloat, isLeft: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = true
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)
        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )
        
        view.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )
        
        if isLeft {
            self.leftViewMode = .always
            leftView = outerView
        } else {
            self.rightViewMode = .always
            rightView = outerView
        }
    }
}

// MARK: - Right Button
extension UITextField {
    func setRightViewButton(_ button: UIButton, padding: CGFloat = 0) {
        additionalViewButton(button, padding: padding, isLeft: false)
    }
    
    private func additionalViewButton(_ button: UIButton, padding: CGFloat, isLeft: Bool) {
        button.translatesAutoresizingMaskIntoConstraints = true
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(button)
        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: button.frame.size.width + padding,
                height: button.frame.size.height + padding
            )
        )
        
        button.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )
        
        if isLeft {
            self.leftViewMode = .always
            leftView = outerView
        } else {
            self.rightViewMode = .always
            rightView = outerView
        }
    }
}
