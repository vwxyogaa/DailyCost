//
//  LoginKey.swift
//  DailyCost
//
//  Created by yxgg on 31/08/23.
//

import Foundation

struct LoginKey {
    static let stateLoginKey = "stateLoginKey"
    static let userIdKey = "userIdKey"
    static let userNameKey = "userNameKey"
    static let tokenKey = "tokenKey"
    
    static var stateLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: stateLoginKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: stateLoginKey)
        }
    }
    
    static var userId: String {
        get {
            return UserDefaults.standard.string(forKey: userIdKey) ?? "0"
        } set {
            UserDefaults.standard.set(newValue, forKey: userIdKey)
        }
    }
    
    static var userName: String {
        get {
            return UserDefaults.standard.string(forKey: userNameKey) ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: userNameKey)
        }
    }
    
    static var token: String {
        get {
            return UserDefaults.standard.string(forKey: tokenKey) ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
    
    static func deleteAllKey() -> Bool {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
            synchronize()
            return true
        } else { return false }
    }
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
