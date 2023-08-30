//
//  APIManager.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import Foundation
import Alamofire
import RxSwift

final class APIManager {
    static let shared = APIManager()
    
    func executeQuery<T> (url: URL, method: HTTPMethod, params: Parameters? = nil) -> Observable<T> where T: Codable {
        return Observable<T>.create { observer in
            AF.request(url, method: method, parameters: params)
                .validate(statusCode: 200...299)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func executeQueryWithJsonEncoding<T> (url: URL, method: HTTPMethod, params: Parameters? = nil, encoding: JSONEncoding = .default) -> Observable<T> where T: Codable {
        return Observable<T>.create { observer in
            AF.request(url, method: method, parameters: params, encoding: encoding)
                .validate(statusCode: 200...299)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
