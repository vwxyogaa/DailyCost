//
//  DepoRepository.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

import Foundation
import RxSwift

protocol DepoRepositoryProtocol {
    func getSaldo(id: Int) -> Observable<DepoModel>
}

final class DepoRepository {
    typealias DepoInstance = (DepoDataSource) -> DepoRepository
    fileprivate let remote: DepoDataSource
    
    init(remote: DepoDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: DepoInstance = { remote in
        return DepoRepository(remote: remote)
    }
}

extension DepoRepository: DepoRepositoryProtocol {
    func getSaldo(id: Int) -> Observable<DepoModel> {
        return remote.getSaldo(id: id)
            .map({ DataMapper.mapDepoResponseToModel(data: $0) })
    }
}
