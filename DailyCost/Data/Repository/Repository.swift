//
//  Repository.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import Foundation
import RxSwift

protocol RepositoryProtocol {
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterResponse>
    func postLogin(email: String, password: String) -> Observable<LoginResponse>
}

final class Repository: NSObject {
    typealias DoctorInstance = (RemoteDataSource) -> Repository
    fileprivate let remote: RemoteDataSource
    
    init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: DoctorInstance = { remote in
        return Repository(remote: remote)
    }
}

extension Repository: RepositoryProtocol {
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterResponse> {
        return remote.postRegister(name: name, email: email, password: password)
    }
    
    func postLogin(email: String, password: String) -> Observable<LoginResponse> {
        return remote.postLogin(email: email, password: password)
    }
}
