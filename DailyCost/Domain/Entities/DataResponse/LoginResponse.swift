//
//  LoginResponse.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

struct LoginResponse: Codable {
    let status, token: String?
    let data: DataClass?
    
    struct DataClass: Codable {
        let id: Int?
        let nama: String?
    }
}

struct LoginBody: Codable {
    let email, password: String?
}
