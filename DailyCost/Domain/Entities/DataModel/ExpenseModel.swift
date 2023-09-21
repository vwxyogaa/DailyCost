//
//  ExpenseModel.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

struct ExpenseModel: Codable {
    let dataResults: [Result]?
    let dataPengeluaran: Pengeluaran?
    
    struct Result: Codable {
        let pengeluaranID: Int?
        let nama, tanggal: String?
        let jumlah: Int?
        let pembayaran: String?
        let userID: Int?
        let kategori: String?
        
        enum CodingKeys: String, CodingKey {
            case pengeluaranID = "pengeluaran_id"
            case nama, tanggal, jumlah, pembayaran
            case userID = "user_id"
            case kategori
        }
    }
    
    struct Pengeluaran: Codable {
        let pengeluaranGopay, pengeluaranRekening, pengeluaranCash: Int?
        
        enum CodingKeys: String, CodingKey {
            case pengeluaranGopay = "pengeluaran_gopay"
            case pengeluaranRekening = "pengeluaran_rekening"
            case pengeluaranCash = "pengeluaran_cash"
        }
    }
}
