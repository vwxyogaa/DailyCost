//
//  Injection.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

final class Injection {
    func provideSignUpUseCase() -> SignUpUseCaseProtocol {
        let repository = provideLoginRegisterRepository()
        return SignUpUseCase(repository: repository)
    }
    
    func provideSignInUseCase() -> SignInUseCaseProtocol {
        let repository = provideLoginRegisterRepository()
        return SignInUseCase(repository: repository)
    }
    
    func provideDashboardUseCase() -> DashboardUseCaseProtocol {
        let repository = provideDepoRepository()
        return DashboardUseCase(repository: repository)
    }
}

extension Injection {
    func provideLoginRegisterRepository() -> LoginRegisterRepositoryProtocol {
        let loginRegisterDataSource = LoginRegisterDataSource()
        return LoginRegisterRepository.sharedInstance(loginRegisterDataSource)
    }
    
    func provideDepoRepository() -> DepoRepositoryProtocol {
        let depoDataSource = DepoDataSource()
        return DepoRepository.sharedInstance(depoDataSource)
    }
}
