//
//  NSLayoutConstraint+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import UIKit

// MARK: - Activated NSLayoutConstraint
extension NSLayoutConstraint {
    public func activated() {
        NSLayoutConstraint.activate([self])
    }
}
