//
//  SignInUseCase.swift
//  DailyCost
//
//  Created by yxgg on 31/08/23.
//

import RxSwift

protocol SignInUseCaseProtocol {
    func postLogin(email: String, password: String) -> Observable<LoginModel>
}

final class SignInUseCase: SignInUseCaseProtocol {
    private let loginRegisterRepository: LoginRegisterRepositoryProtocol
    
    init(loginRegisterRepository: LoginRegisterRepositoryProtocol) {
        self.loginRegisterRepository = loginRegisterRepository
    }
    
    func postLogin(email: String, password: String) -> Observable<LoginModel> {
        return loginRegisterRepository.postLogin(email: email, password: password)
    }
}
