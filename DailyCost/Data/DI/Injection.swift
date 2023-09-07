//
//  Injection.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

final class Injection {
    func provideSignUpUseCase() -> SignUpUseCaseProtocol {
        let repository = provideRepository()
        return SignUpUseCase(repository: repository)
    }
    
    func provideSignInUseCase() -> SignInUseCaseProtocol {
        let repository = provideRepository()
        return SignInUseCase(repository: repository)
    }
}

extension Injection {
    func provideRepository() -> LoginRegisterRepositoryProtocol {
        let loginRegisterDataSource = LoginRegisterDataSource()
        return LoginRegisterRepository.sharedInstance(loginRegisterDataSource)
    }
}
