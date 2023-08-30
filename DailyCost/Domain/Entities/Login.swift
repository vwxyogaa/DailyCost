//
//  Login.swift
//  DailyCost
//
//  Created by yxgg on 31/08/23.
//

struct LoginResponse: Codable {
    let status, token: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let id: Int?
    let nama: String?
}

struct LoginBody: Codable {
    let email, password: String?
}
