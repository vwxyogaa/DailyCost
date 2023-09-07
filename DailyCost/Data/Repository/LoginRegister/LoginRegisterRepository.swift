//
//  LoginRegisterRepository.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

import Foundation
import RxSwift

protocol LoginRegisterRepositoryProtocol {
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterModel>
    func postLogin(email: String, password: String) -> Observable<LoginModel>
}

final class LoginRegisterRepository {
    typealias LoginRegisterInstance = (LoginRegisterDataSource) -> LoginRegisterRepository
    fileprivate let remote: LoginRegisterDataSource
    
    init(remote: LoginRegisterDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: LoginRegisterInstance = { remote in
        return LoginRegisterRepository(remote: remote)
    }
}

extension LoginRegisterRepository: LoginRegisterRepositoryProtocol {
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterModel> {
        return remote.postRegister(name: name, email: email, password: password)
            .map({ DataMapper.mapRegisterResponseToModel(data: $0) })
    }
    
    func postLogin(email: String, password: String) -> Observable<LoginModel> {
        return remote.postLogin(email: email, password: password)
            .map({ DataMapper.mapLoginResponseToModel(data: $0) })
    }
}
