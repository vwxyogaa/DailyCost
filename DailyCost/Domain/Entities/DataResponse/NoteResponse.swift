//
//  NoteResponse.swift
//  DailyCost
//
//  Created by Panji Yoga on 19/09/23.
//

struct NoteResponse: Codable {
    let status, message: String?
    let data: [Data]?
    
    struct Data: Codable {
        let catatanId: Int?
        let title, body, createdAt: String?
        let createdAtEpoch, userId: Int?
        let url: String?
        
        enum CodingKeys: String, CodingKey {
            case catatanId = "catatan_id"
            case title, body
            case createdAt = "created_at"
            case createdAtEpoch = "created_at_epoch"
            case userId = "user_id"
            case url
        }
    }
}
