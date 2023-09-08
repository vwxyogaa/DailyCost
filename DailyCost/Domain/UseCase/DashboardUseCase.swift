//
//  DashboardUseCase.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

import RxSwift

protocol DashboardUseCaseProtocol {
    func getSaldo(id: Int) -> Observable<DepoModel>
}

final class DashboardUseCase: DashboardUseCaseProtocol {
    private let repository: DepoRepositoryProtocol
    
    init(repository: DepoRepositoryProtocol) {
        self.repository = repository
    }
    
    func getSaldo(id: Int) -> Observable<DepoModel> {
        return repository.getSaldo(id: id)
    }
}
