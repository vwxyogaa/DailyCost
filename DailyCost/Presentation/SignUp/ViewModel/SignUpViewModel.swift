//
//  SignUpViewModel.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import RxSwift
import RxCocoa

class SignUpViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let signUpUseCase: SignUpUseCaseProtocol
    
    private let _register = BehaviorRelay<RegisterModel?>(value: nil)
    
    var isPasswordVisible: Bool = false
    
    init(signUpUseCase: SignUpUseCaseProtocol) {
        self.signUpUseCase = signUpUseCase
    }
    
    var register: Driver<RegisterModel?> {
        return _register.asDriver()
    }
    
    var registerValue: RegisterModel? {
        return _register.value
    }
    
    func postRegister(name: String, email: String, password: String) {
        self._isLoading.accept(true)
        signUpUseCase.postRegister(name: name, email: email, password: password)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._register.accept(result)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
