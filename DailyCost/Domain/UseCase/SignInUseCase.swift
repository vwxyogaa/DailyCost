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
    private let repository: LoginRegisterRepositoryProtocol
    
    init(repository: LoginRegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func postLogin(email: String, password: String) -> Observable<LoginModel> {
        return repository.postLogin(email: email, password: password)
    }
}
