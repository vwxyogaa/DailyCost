//
//  RegisterResponse.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

struct RegisterResponse: Codable {
    let message, token: String?
    let data: RegisterData?
    
    struct RegisterData: Codable {
        let id: Int?
    }
}

struct RegisterBody: Codable {
    let name, email, password: String?
}
