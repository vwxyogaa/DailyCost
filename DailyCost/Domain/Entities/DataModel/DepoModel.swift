//
//  DepoModel.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

struct DepoModel: Codable {
    let status: String?
    let message: String?
    let dataUserId: Int?
    let dataUangGopay: Double?
    let dataUangCash: Double?
    let dataUangRekening: Double?
}
