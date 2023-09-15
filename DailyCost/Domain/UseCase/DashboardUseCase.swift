//
//  DashboardUseCase.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

import RxSwift

protocol DashboardUseCaseProtocol {
    func getSaldo(id: Int) -> Observable<DepoModel>
    func getPengeluaran(id: Int) -> Observable<SpendingModel>
}

final class DashboardUseCase: DashboardUseCaseProtocol {
    private let depoRepository: DepoRepositoryProtocol
    private let pengeluaranRepository: PengeluaranRepositoryProtocol
    
    init(depoRepository: DepoRepositoryProtocol, pengeluaranRepository: PengeluaranRepositoryProtocol) {
        self.depoRepository = depoRepository
        self.pengeluaranRepository = pengeluaranRepository
    }
    
    func getSaldo(id: Int) -> Observable<DepoModel> {
        return depoRepository.getSaldo(id: id)
    }
    
    func getPengeluaran(id: Int) -> Observable<SpendingModel> {
        return pengeluaranRepository.getPengeluaran(id: id)
    }
}
