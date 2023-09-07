//
//  RegisterResponse.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
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
