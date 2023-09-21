//
//  Injection.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

final class Injection {
    func provideSignUpUseCase() -> SignUpUseCaseProtocol {
        let loginRegisterRepository = provideLoginRegisterRepository()
        return SignUpUseCase(loginRegisterRepository: loginRegisterRepository)
    }
    
    func provideSignInUseCase() -> SignInUseCaseProtocol {
        let loginRegisterRepository = provideLoginRegisterRepository()
        return SignInUseCase(loginRegisterRepository: loginRegisterRepository)
    }
    
    func provideDashboardUseCase() -> DashboardUseCaseProtocol {
        let depoRepository = provideDepoRepository()
        let expenseRepository = provideExpenseRepository()
        let noteRepository = provideNoteRepository()
        let incomeRepository = provideIncomeRepository()
        return DashboardUseCase(depoRepository: depoRepository, expenseRepository: expenseRepository, noteRepository: noteRepository, incomeRepository: incomeRepository)
    }
}

extension Injection {
    func provideIncomeRepository() -> IncomeRepositoryProtocol {
        let incomeDataSource = IncomeDataSource()
        return IncomeRepository.sharedInstance(incomeDataSource)
    }
    
    func provideNoteRepository() -> NoteRepositoryProtocol {
        let noteDataSource = NoteDataSource()
        return NoteRepository.sharedInstance(noteDataSource)
    }
    
    func provideExpenseRepository() -> ExpenseRepositoryProtocol {
        let expenseDataSource = ExpenseDataSource()
        return ExpenseRepository.sharedInstance(expenseDataSource)
    }
    
    func provideLoginRegisterRepository() -> LoginRegisterRepositoryProtocol {
        let loginRegisterDataSource = LoginRegisterDataSource()
        return LoginRegisterRepository.sharedInstance(loginRegisterDataSource)
    }
    
    func provideDepoRepository() -> DepoRepositoryProtocol {
        let depoDataSource = DepoDataSource()
        return DepoRepository.sharedInstance(depoDataSource)
    }
}
