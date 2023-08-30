//
//  UIViewController+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

extension UIViewController {
    var shouldHideBackButtonText: Bool {
        get {
            return false
        }
        set {
            if newValue {
                let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
                navigationController?.navigationBar.tintColor = .text200
            } else {
                navigationController?.navigationBar.tintColor = .systemBlue
            }
        }
    }
}
