//
//  IncomeRepository.swift
//  DailyCost
//
//  Created by Panji Yoga on 21/09/23.
//

import Foundation
import RxSwift

protocol IncomeRepositoryProtocol {
    func getPemasukan(id: Int) -> Observable<IncomeModel>
}

final class IncomeRepository {
    typealias IncomeInstance = (IncomeDataSource) -> IncomeRepository
    fileprivate let remote: IncomeDataSource
    
    init(remote: IncomeDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: IncomeInstance = { remote in
        return IncomeRepository(remote: remote)
    }
}

extension IncomeRepository: IncomeRepositoryProtocol {
    func getPemasukan(id: Int) -> Observable<IncomeModel> {
        return remote.getPemasukan(id: id)
            .map({ DataMapper.mapIncomeResponseToModel(data: $0) })
    }
}
