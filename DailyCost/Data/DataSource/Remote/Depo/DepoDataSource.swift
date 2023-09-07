//
//  DepoDataSource.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

import Foundation
import RxSwift

final class DepoDataSource {
    func getSaldo(id: Int) -> Observable<DepoResponse> {
        let url = URL(string: "https://dailycost.my.id/api/saldo/\(id)")!
        let data: Observable<DepoResponse> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
}
