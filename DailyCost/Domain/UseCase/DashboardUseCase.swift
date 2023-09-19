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
    func getCatatan(id: Int) -> Observable<NoteModel>
}

final class DashboardUseCase: DashboardUseCaseProtocol {
    private let depoRepository: DepoRepositoryProtocol
    private let pengeluaranRepository: PengeluaranRepositoryProtocol
    private let catatanRepository: CatatanRepositoryProtocol
    
    init(depoRepository: DepoRepositoryProtocol, pengeluaranRepository: PengeluaranRepositoryProtocol, catatanRepository: CatatanRepositoryProtocol) {
        self.depoRepository = depoRepository
        self.pengeluaranRepository = pengeluaranRepository
        self.catatanRepository = catatanRepository
    }
    
    func getSaldo(id: Int) -> Observable<DepoModel> {
        return depoRepository.getSaldo(id: id)
    }
    
    func getPengeluaran(id: Int) -> Observable<SpendingModel> {
        return pengeluaranRepository.getPengeluaran(id: id)
    }
    
    func getCatatan(id: Int) -> Observable<NoteModel> {
        return catatanRepository.getCatatan(id: id)
    }
}
