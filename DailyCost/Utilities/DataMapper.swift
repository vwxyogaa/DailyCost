//
//  DataMapper.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

final class DataMapper {
    static func mapRegisterResponseToModel(data: RegisterResponse) -> RegisterModel {
        return RegisterModel(
            message: data.message,
            token: data.token,
            dataId: data.data?.id
        )
    }
    
    static func mapLoginResponseToModel(data: LoginResponse) -> LoginModel {
        return LoginModel(
            status: data.status,
            token: data.token,
            dataId: data.data?.id,
            dataNama: data.data?.nama
        )
    }
    
    static func mapDepoResponseToModel(data: DepoResponse) -> DepoModel {
        return DepoModel(
            dataUserId: data.data?.userId,
            dataUangGopay: data.data?.uangGopay,
            dataUangCash: data.data?.uangCash,
            dataUangRekening: data.data?.uangRekening
        )
    }
    
    static func mapSpendingResponseToModel(data: ExpenseResponse) -> ExpenseModel {
        var pengeluaranIds: [Int] = []
        var namas: [String] = []
        var tanggals: [String] = []
        var jumlahs: [Int] = []
        var pembayarans: [String] = []
        var userIds: [Int] = []
        var kategoris: [String] = []
        
        if let results = data.data?.results {
            for result in results {
                pengeluaranIds.append(result.pengeluaranId ?? 0)
                namas.append(result.nama ?? "")
                tanggals.append(result.tanggal ?? "")
                jumlahs.append(result.jumlah ?? 0)
                pembayarans.append(result.pembayaran ?? "")
                userIds.append(result.userId ?? 0)
                kategoris.append(result.kategori ?? "")
            }
        }
        
        let pengeluaranGopay = data.data?.pengeluaran?.pengeluaranGopay
        let pengeluaranRekening = data.data?.pengeluaran?.pengeluaranRekening
        let pengeluaranCash = data.data?.pengeluaran?.pengeluaranCash
        return ExpenseModel(
            pengeluaranId: pengeluaranIds,
            nama: namas,
            tanggal: tanggals,
            jumlah: jumlahs,
            pembayaran: pembayarans,
            userId: userIds,
            kategori: kategoris,
            pengeluaranGopay: pengeluaranGopay,
            pengeluaranRekening: pengeluaranRekening,
            pengeluaranCash: pengeluaranCash
        )
    }
    
    static func mapNoteResponseToModel(data: NoteResponse) -> NoteModel {
        var catatanIds: [Int] = []
        var titles: [String] = []
        var bodies: [String] = []
        var createdAts: [String] = []
        var userIds: [Int] = []
        
        data.data?.forEach { dataItem in
            if let catatanId = dataItem.catatanId {
                catatanIds.append(catatanId)
            }
            
            if let title = dataItem.title {
                titles.append(title)
            }
            
            if let body = dataItem.body {
                bodies.append(body)
            }
            
            if let createdAt = dataItem.createdAt {
                createdAts.append(createdAt)
            }
            
            if let userId = dataItem.userId {
                userIds.append(userId)
            }
        }
        let noteModel = NoteModel(
            catatanId: catatanIds,
            title: titles,
            body: bodies,
            createdAt: createdAts,
            userId: userIds
        )
        
        return noteModel
    }
    
    static func mapIncomeResponseToModel(data: IncomeResponse) -> IncomeModel {
        var pemasukanIds: [Int] = []
        var namas: [String] = []
        var tanggals: [String] = []
        var jumlahs: [Int] = []
        var pembayarans: [String] = []
        var kategoris: [String] = []
        
        data.data?.forEach({ dataItem in
            if let pemasukanId = dataItem.pemasukanId {
                pemasukanIds.append(pemasukanId)
            }
            
            if let nama = dataItem.nama {
                namas.append(nama)
            }
            
            if let tanggal = dataItem.tanggal {
                tanggals.append(tanggal)
            }
            
            if let jumlah = dataItem.jumlah {
                jumlahs.append(jumlah)
            }
            
            if let pembayaran = dataItem.pembayaran {
                pembayarans.append(pembayaran)
            }
            
            if let kategori = dataItem.kategori {
                kategoris.append(kategori)
            }
        })
        let incomeModel = IncomeModel(
            pemasukanId: pemasukanIds,
            nama: namas,
            tanggal: tanggals,
            jumlah: jumlahs,
            pembayaran: pembayarans,
            kategori: kategoris
        )
        
        return incomeModel
    }
}
