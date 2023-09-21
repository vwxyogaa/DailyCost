//
//  ExpenseDataSource.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import Foundation
import RxSwift

final class ExpenseDataSource {
    func getPengeluaran(id: Int) -> Observable<ExpenseResponse> {
        let url = URL(string: "https://dailycost.my.id/api/pengeluaran/\(id)")!
        let data: Observable<ExpenseResponse> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
}
