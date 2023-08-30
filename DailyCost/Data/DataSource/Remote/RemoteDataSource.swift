//
//  RemoteDataSource.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import Foundation
import RxSwift

final class RemoteDataSource {
    func postRegister( name: String, email: String, password: String) -> Observable<RegisterResponse> {
        let registerBody = RegisterBody(name: name, email: email, password: password)
        let parameters = Utils.convertToParameters(registerBody)
        let url = URL(string: "https://dailycost.my.id/register")!
        let data: Observable<RegisterResponse> = APIManager.shared.executeQuery(url: url, method: .post, params: parameters)
        return data
    }
}
