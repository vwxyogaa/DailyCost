//
//  DashboardViewModel.swift
//  DailyCost
//
//  Created by yxgg on 07/09/23.
//

import RxSwift
import RxCocoa

class DashboardViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let dashboardUseCase: DashboardUseCaseProtocol
    
    private let _saldo = BehaviorRelay<DepoModel?>(value: nil)
    private let _expense = BehaviorRelay<ExpenseModel?>(value: nil)
    private let _note = BehaviorRelay<NoteModel?>(value: nil)
    private let _income = BehaviorRelay<IncomeModel?>(value: nil)
    
    var userId: Int
    var isOpen: Bool = false
    
    init(dashboardUseCase: DashboardUseCaseProtocol, userId: Int) {
        self.dashboardUseCase = dashboardUseCase
        self.userId = userId
    }
    
    // MARK: - Saldo
    var saldo: Driver<DepoModel?> {
        return _saldo.asDriver()
    }
    
    var saldoValue: DepoModel? {
        return _saldo.value
    }
    
    func getSaldo(id: Int) {
        self._isLoading.accept(true)
        dashboardUseCase.getSaldo(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._saldo.accept(result)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Expense
    var expense: Driver<ExpenseModel?> {
        return _expense.asDriver()
    }
    
    var expenseValue: ExpenseModel? {
        return _expense.value
    }
    
    func getPengeluaran(id: Int) {
        self._isLoading.accept(true)
        dashboardUseCase.getPengeluaran(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._expense.accept(result)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Catatan
    var catatan: Driver<NoteModel?> {
        return _note.asDriver()
    }
    
    var catatanValue: NoteModel? {
        return _note.value
    }
    
    func getCatatan(id: Int) {
        self._isLoading.accept(true)
        dashboardUseCase.getCatatan(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._note.accept(result)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Income
    var income: Driver<IncomeModel?> {
        return _income.asDriver()
    }
    
    var incomeValue: IncomeModel? {
        return _income.value
    }
    
    func getPemasukan(id: Int) {
        self._isLoading.accept(true)
        dashboardUseCase.getPemasukan(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._income.accept(result)
                self.getPengeluaran(id: id)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
