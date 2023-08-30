//
//  SignInUseCase.swift
//  DailyCost
//
//  Created by yxgg on 31/08/23.
//

import RxSwift

protocol SignInUseCaseProtocol {
    func postLogin(email: String, password: String) -> Observable<LoginResponse>
}

final class SignInUseCase: SignInUseCaseProtocol {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func postLogin(email: String, password: String) -> Observable<LoginResponse> {
        return repository.postLogin(email: email, password: password)
    }
}
