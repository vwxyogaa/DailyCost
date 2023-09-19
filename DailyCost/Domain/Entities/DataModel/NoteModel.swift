//
//  NoteModel.swift
//  DailyCost
//
//  Created by Panji Yoga on 19/09/23.
//

struct NoteModel: Codable {
    let catatanId: [Int]?
    let title: [String]?
    let body: [String]?
    let createdAt: [String]?
    let userId: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case body, title
        case catatanId = "catatan_id"
        case createdAt = "created_at"
        case userId = "user_id"
    }
}
