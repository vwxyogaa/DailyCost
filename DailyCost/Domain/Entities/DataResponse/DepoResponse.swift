//
//  DepoResponse.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

struct DepoResponse: Codable {
    let status: String?
    let message: String?
    let data: DepoData?
    
    struct DepoData: Codable {
        let userId: Int?
        let uangGopay: Double?
        let uangCash: Double?
        let uangRekening: Double?
        
        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case uangGopay = "uang_gopay"
            case uangCash = "uang_cash"
            case uangRekening = "uang_rekening"
        }
    }
}
