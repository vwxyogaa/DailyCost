//
//  Array+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 22/09/23.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
