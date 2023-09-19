//
//  SignUpUseCase.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import RxSwift

protocol SignUpUseCaseProtocol {
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterModel>
}

final class SignUpUseCase: SignUpUseCaseProtocol {
    private let loginRegisterRepository: LoginRegisterRepositoryProtocol
    
    init(loginRegisterRepository: LoginRegisterRepositoryProtocol) {
        self.loginRegisterRepository = loginRegisterRepository
    }
    
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterModel> {
        return loginRegisterRepository.postRegister(name: name, email: email, password: password)
    }
}
