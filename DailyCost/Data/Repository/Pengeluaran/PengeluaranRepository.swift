//
//  PengeluaranRepository.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import Foundation
import RxSwift

protocol PengeluaranRepositoryProtocol {
    func getPengeluaran(id: Int) -> Observable<SpendingModel>
}

final class PengeluaranRepository {
    typealias PengeluaranInstance = (PengeluaranDataSource) -> PengeluaranRepository
    fileprivate let remote: PengeluaranDataSource
    
    init(remote: PengeluaranDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: PengeluaranInstance = { remote in
        return PengeluaranRepository(remote: remote)
    }
}

extension PengeluaranRepository: PengeluaranRepositoryProtocol {
    func getPengeluaran(id: Int) -> Observable<SpendingModel> {
        return remote.getPengeluaran(id: id)
            .map({ DataMapper.mapSpendingResponseToModel(data: $0) })
    }
}
