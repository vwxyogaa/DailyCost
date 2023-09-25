//
//  IncomeDataSource.swift
//  DailyCost
//
//  Created by Panji Yoga on 21/09/23.
//

import Foundation
import RxSwift

final class IncomeDataSource {
    func getPemasukan(id: Int) -> Observable<IncomeResponse> {
        let url = URL(string: "https://dailycost.my.id/api/pemasukan/\(id)")!
        let data: Observable<IncomeResponse> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
}
