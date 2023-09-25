//
//  ExpenseModel.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

struct ExpenseModel: Codable {
    let pengeluaranId: [Int]?
    let nama, tanggal: [String]?
    let jumlah: [Int]?
    let pembayaran: [String]?
    let userId: [Int]?
    let kategori: [String]?
    let pengeluaranGopay, pengeluaranRekening, pengeluaranCash: Int?
    
    enum CodingKeys: String, CodingKey {
        case pengeluaranId = "pengeluaran_id"
        case nama, tanggal, jumlah, pembayaran
        case userId = "user_id"
        case kategori
        case pengeluaranGopay = "pengeluaran_gopay"
        case pengeluaranRekening = "pengeluaran_rekening"
        case pengeluaranCash = "pengeluaran_cash"
    }
}
