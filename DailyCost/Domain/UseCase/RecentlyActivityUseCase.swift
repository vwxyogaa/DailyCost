//
//  RecentlyActivityUseCase.swift
//  DailyCost
//
//  Created by Panji Yoga on 22/09/23.
//

import RxSwift

protocol RecentlyActivityUseCaseProtocol {
    func getPengeluaran(id: Int) -> Observable<ExpenseModel>
    func getPemasukan(id: Int) -> Observable<IncomeModel>
}

final class RecentlyActivityUseCase: RecentlyActivityUseCaseProtocol {
    private let expenseRepository: ExpenseRepositoryProtocol
    private let incomeRepository: IncomeRepositoryProtocol
    
    init(expenseRepository: ExpenseRepositoryProtocol, incomeRepository: IncomeRepositoryProtocol) {
        self.expenseRepository = expenseRepository
        self.incomeRepository = incomeRepository
    }
    
    func getPengeluaran(id: Int) -> Observable<ExpenseModel> {
        return expenseRepository.getPengeluaran(id: id)
    }
    
    func getPemasukan(id: Int) -> Observable<IncomeModel> {
        return incomeRepository.getPemasukan(id: id)
    }
}
