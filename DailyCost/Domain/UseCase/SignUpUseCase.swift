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
    private let repository: LoginRegisterRepositoryProtocol
    
    init(repository: LoginRegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterModel> {
        return repository.postRegister(name: name, email: email, password: password)
    }
}
