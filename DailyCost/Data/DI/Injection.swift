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
        let pengeluaranRepository = providePengeluaranRepsitory()
        return DashboardUseCase(depoRepository: depoRepository, pengeluaranRepository: pengeluaranRepository)
    }
}

extension Injection {
    func providePengeluaranRepsitory() -> PengeluaranRepositoryProtocol {
        let pengeluaranDataSource = PengeluaranDataSource()
        return PengeluaranRepository.sharedInstance(pengeluaranDataSource)
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
