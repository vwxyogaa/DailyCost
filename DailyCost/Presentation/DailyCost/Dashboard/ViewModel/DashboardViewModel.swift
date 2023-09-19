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
    private let _spending = BehaviorRelay<SpendingModel?>(value: nil)
    private let _catatan = BehaviorRelay<NoteModel?>(value: nil)
    
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
    
    // MARK: - Pengeluaran
    var spending: Driver<SpendingModel?> {
        return _spending.asDriver()
    }
    
    var spendingValue: SpendingModel? {
        return _spending.value
    }
    
    func getPengeluaran(id: Int) {
        self._isLoading.accept(true)
        dashboardUseCase.getPengeluaran(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._spending.accept(result)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Catatan
    var catatan: Driver<NoteModel?> {
        return _catatan.asDriver()
    }
    
    var catatanValue: NoteModel? {
        return _catatan.value
    }
    
    func getCatatan(id: Int) {
        self._isLoading.accept(true)
        dashboardUseCase.getCatatan(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._catatan.accept(result)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
