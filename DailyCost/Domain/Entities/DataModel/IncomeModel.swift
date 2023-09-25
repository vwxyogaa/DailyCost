//
//  IncomeModel.swift
//  DailyCost
//
//  Created by Panji Yoga on 21/09/23.
//

struct IncomeModel: Codable {
    let pemasukanId: [Int]?
    let nama, tanggal: [String]?
    let jumlah: [Int]?
    let pembayaran, kategori: [String]?
    
    enum CodingKeys: String, CodingKey {
        case pemasukanId = "pemasukan_id"
        case nama, tanggal, jumlah, pembayaran, kategori
    }
}
