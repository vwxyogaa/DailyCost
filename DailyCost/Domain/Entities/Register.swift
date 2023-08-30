//
//  Register.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

struct RegisterResponse: Codable {
    let message, token: String?
    let data: DataClass?
    
    struct DataClass: Codable {
        let id: Int?
    }
}

struct RegisterBody: Codable {
    let name, email, password: String?
}
