//
//  DashboardUseCase.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

import RxSwift

protocol DashboardUseCaseProtocol {
    func getSaldo(id: Int) -> Observable<DepoModel>
    func getPengeluaran(id: Int) -> Observable<ExpenseModel>
    func getCatatan(id: Int) -> Observable<NoteModel>
    func getPemasukan(id: Int) -> Observable<IncomeModel>
}

final class DashboardUseCase: DashboardUseCaseProtocol {
    private let depoRepository: DepoRepositoryProtocol
    private let expenseRepository: ExpenseRepositoryProtocol
    private let noteRepository: NoteRepositoryProtocol
    private let incomeRepository: IncomeRepositoryProtocol
    
    init(depoRepository: DepoRepositoryProtocol, expenseRepository: ExpenseRepositoryProtocol, noteRepository: NoteRepositoryProtocol, incomeRepository: IncomeRepositoryProtocol) {
        self.depoRepository = depoRepository
        self.expenseRepository = expenseRepository
        self.noteRepository = noteRepository
        self.incomeRepository = incomeRepository
    }
    
    func getSaldo(id: Int) -> Observable<DepoModel> {
        return depoRepository.getSaldo(id: id)
    }
    
    func getPengeluaran(id: Int) -> Observable<ExpenseModel> {
        return expenseRepository.getPengeluaran(id: id)
    }
    
    func getCatatan(id: Int) -> Observable<NoteModel> {
        return noteRepository.getCatatan(id: id)
    }
    
    func getPemasukan(id: Int) -> Observable<IncomeModel> {
        return incomeRepository.getPemasukan(id: id)
    }
}
