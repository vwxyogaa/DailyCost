//
//  SignUpUseCase.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import RxSwift

protocol SignUpUseCaseProtocol {
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterResponse>
}

final class SignUpUseCase: SignUpUseCaseProtocol {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterResponse> {
        return repository.postRegister(name: name, email: email, password: password)
    }
}
