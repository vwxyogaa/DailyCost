//
//  SignInViewModel.swift
//  DailyCost
//
//  Created by yxgg on 31/08/23.
//

import RxSwift
import RxCocoa

class SignInViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let signInUseCase: SignInUseCaseProtocol
    
    private let _login = BehaviorRelay<LoginModel?>(value: nil)
    
    var isPasswordVisible: Bool = false
    
    init(signInUseCase: SignInUseCaseProtocol) {
        self.signInUseCase = signInUseCase
    }
    
    var login: Driver<LoginModel?> {
        return _login.asDriver()
    }
    
    var loginValue: LoginModel? {
        return _login.value
    }
    
    func postLogin(email: String, password: String) {
        self._isLoading.accept(true)
        signInUseCase.postLogin(email: email, password: password)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._login.accept(result)
                LoginKey.userId = String(result.dataId ?? 0)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
