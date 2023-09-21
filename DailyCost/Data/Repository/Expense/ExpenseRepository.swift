//
//  ExpenseRepository.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import Foundation
import RxSwift

protocol ExpenseRepositoryProtocol {
    func getPengeluaran(id: Int) -> Observable<ExpenseModel>
}

final class ExpenseRepository {
    typealias ExpenseInstance = (ExpenseDataSource) -> ExpenseRepository
    fileprivate let remote: ExpenseDataSource
    
    init(remote: ExpenseDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: ExpenseInstance = { remote in
        return ExpenseRepository(remote: remote)
    }
}

extension ExpenseRepository: ExpenseRepositoryProtocol {
    func getPengeluaran(id: Int) -> Observable<ExpenseModel> {
        return remote.getPengeluaran(id: id)
            .map({ DataMapper.mapSpendingResponseToModel(data: $0) })
    }
}
