//
//  RecentlyActivityViewModel.swift
//  DailyCost
//
//  Created by Panji Yoga on 22/09/23.
//

import RxSwift
import RxCocoa

class RecentlyActivityViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let recentlyActivityUseCase: RecentlyActivityUseCaseProtocol
    
    private let _expense = BehaviorRelay<ExpenseModel?>(value: nil)
    private let _income = BehaviorRelay<IncomeModel?>(value: nil)
    private let _recentlyActivity = BehaviorRelay<[ActivityModel]?>(value: nil)
    
    var userId: Int
    var activitiesByDate = [String: [ActivityModel]]()
    
    init(recentlyActivityUseCase: RecentlyActivityUseCaseProtocol, userId: Int) {
        self.recentlyActivityUseCase = recentlyActivityUseCase
        self.userId = userId
    }
    
    // MARK: - Expense
    var expenseValue: ExpenseModel? {
        return _expense.value
    }
    
    func getPengeluaran(id: Int) {
        self._isLoading.accept(true)
        recentlyActivityUseCase.getPengeluaran(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._expense.accept(result)
                self.getPemasukan(id: self.userId)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Income
    var incomeValue: IncomeModel? {
        return _income.value
    }
    
    func getPemasukan(id: Int) {
        self._isLoading.accept(true)
        recentlyActivityUseCase.getPemasukan(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._income.accept(result)
                self.combineAndSortActivities()
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Recently activity
    var recentlyActivity: Driver<[ActivityModel]?> {
        return _recentlyActivity.asDriver()
    }
    
    var recentlyActivityValue: [ActivityModel]? {
        return _recentlyActivity.value
    }
    
    func combineAndSortActivities() {
        var combined: [ActivityModel] = []
        
        if let expenses = self.expenseValue {
            for i in 0..<(expenses.userId?.count ?? 0) {
                if let originalDate = expenses.tanggal?[i] {
                    let convertedDate = originalDate.convertDateString(fromFormat: .dayMonthYearWithTimeV2, toFormat: .serverDate)
                    let activity = ActivityModel(id: expenses.pengeluaranId?[i],
                                                 name: expenses.nama?[i],
                                                 date: convertedDate,
                                                 amount: expenses.jumlah?[i],
                                                 category: expenses.kategori?[i],
                                                 type: .expense)
                    combined.append(activity)
                }
            }
        }
        
        if let incomes = self.incomeValue {
            for i in 0..<(incomes.pemasukanId?.count ?? 0) {
                if let originalDate = incomes.tanggal?[i] {
                    let convertedDate = originalDate.convertDateString(fromFormat: .serverDateWitTimeAndTandZ, toFormat: .serverDate)
                    let activity = ActivityModel(id: incomes.pemasukanId?[i],
                                                 name: incomes.nama?[i],
                                                 date: convertedDate,
                                                 amount: incomes.jumlah?[i],
                                                 category: incomes.kategori?[i],
                                                 type: .income)
                    combined.append(activity)
                }
            }
        }
        
        let sortedActivities = combined.sorted { $0.date ?? "0" > $1.date ?? "0" }
        
        activitiesByDate.removeAll()
        for activity in sortedActivities {
            if let date = activity.date {
                if activitiesByDate[date] == nil {
                    activitiesByDate[date] = []
                }
                activitiesByDate[date]?.append(activity)
            }
        }
        self._recentlyActivity.accept(sortedActivities)
    }
}
