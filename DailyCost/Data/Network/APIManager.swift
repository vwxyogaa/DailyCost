//
//  APIManager.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import Foundation
import Alamofire
import RxSwift
import UIKit

final class APIManager {
    static let shared = APIManager()
    
    func executeQuery<T> (url: URL, method: HTTPMethod, params: Parameters? = nil) -> Observable<T> where T: Codable {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer " + LoginKey.token
        ]
        return Observable<T>.create { observer in
            AF.request(url, method: method, parameters: params, headers: headers)
                .validate(statusCode: 200...299)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode, statusCode == 403 {
                            self.redirectToOnBoardingPage()
                        } else {
                            observer.onError(error)
                        }
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
                        if let statusCode = response.response?.statusCode, statusCode == 403 {
                            self.redirectToOnBoardingPage()
                        } else {
                            observer.onError(error)
                        }
                    }
                }
            return Disposables.create()
        }
    }
    
    private func redirectToOnBoardingPage() {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }
        
        let rootController = OnboardingViewController()
        let snapshot = firstWindow.snapshotView(afterScreenUpdates: true)!
        rootController.view.addSubview(snapshot)
        
        firstWindow.rootViewController = rootController
        
        UIView.transition(with: snapshot,
                          duration: 0.3,
                          options: .curveEaseInOut,
                          animations: {
            snapshot.layer.opacity = 0
        },
                          completion: { status in
            snapshot.removeFromSuperview()
        })
        firstWindow.makeKeyAndVisible()
    }
}
