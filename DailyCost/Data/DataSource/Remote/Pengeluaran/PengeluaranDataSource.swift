//
//  PengeluaranDataSource.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import Foundation
import RxSwift

final class PengeluaranDataSource {
    func getPengeluaran(id: Int) -> Observable<SpendingResponse> {
        let url = URL(string: "https://dailycost.my.id/api/pengeluaran/\(id)")!
        let data: Observable<SpendingResponse> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
}
