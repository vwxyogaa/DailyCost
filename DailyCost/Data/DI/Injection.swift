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
        let pengeluaranRepository = providePengeluaranRepository()
        let catatanRepository = provideCatatanRepository()
        return DashboardUseCase(depoRepository: depoRepository, pengeluaranRepository: pengeluaranRepository, catatanRepository: catatanRepository)
    }
}

extension Injection {
    func provideCatatanRepository() -> CatatanRepositoryProtocol {
        let catatanDataSource = CatatanDataSource()
        return CatatanRepository.sharedInstance(catatanDataSource)
    }
    
    func providePengeluaranRepository() -> PengeluaranRepositoryProtocol {
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
