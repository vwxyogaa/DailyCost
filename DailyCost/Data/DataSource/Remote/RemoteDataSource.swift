//
//  RemoteDataSource.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import Foundation
import RxSwift

final class RemoteDataSource {
    func postRegister(name: String, email: String, password: String) -> Observable<RegisterResponse> {
        let registerBody = RegisterBody(name: name, email: email, password: password)
        let parameters = Utils.convertToParameters(registerBody)
        let url = URL(string: "https://dailycost.my.id/register")!
        let data: Observable<RegisterResponse> = APIManager.shared.executeQueryWithJsonEncoding(url: url, method: .post, params: parameters)
        return data
    }
    
    func postLogin(email: String, password: String) -> Observable<LoginResponse> {
        let loginBody = LoginBody(email: email, password: password)
        let parameters = Utils.convertToParameters(loginBody)
        let url = URL(string: "https://dailycost.my.id/login")!
        let data: Observable<LoginResponse> = APIManager.shared.executeQueryWithJsonEncoding(url: url, method: .post, params: parameters)
        return data
    }
}
