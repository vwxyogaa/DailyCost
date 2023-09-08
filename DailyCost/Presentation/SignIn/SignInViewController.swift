//
//  SignInViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit
import RxSwift

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var checkboxRememberMeButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Views
    private lazy var visiblePasswordButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "icon_eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .text200
        button.setTitle("", for: .normal)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    var viewModel: SignInViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
        initListener()
        configureRxValidation()
        initObserver()
    }
    
    // MARK: - Helpers
    private func configureViews() {
        emailTextField.layer.borderColor = UIColor.bg200.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 9
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.borderColor = UIColor.bg200.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 9
        passwordTextField.layer.masksToBounds = true
        passwordTextField.setRightViewButton(visiblePasswordButton, padding: 16)
        
        signInButton.layer.cornerRadius = 12
        signInButton.layer.masksToBounds = true
        
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    private func initListener() {
        visiblePasswordButton.addTarget(self, action: #selector(self.eyeButtonTapped), for: .touchUpInside)
        checkboxRememberMeButton.addTarget(self, action: #selector(checkboxRememberMeButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func initObserver() {
        viewModel.login.drive(onNext: { [weak self] login in
            if login != nil {
                self?.goToDashboard()
            }
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.drive(onNext: { [weak self] isLoading in
            self?.manageLoadingActivity(isLoading: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel.errorMessage.drive(onNext: { [weak self] errorMessage in
            self?.showErrorSnackBar(message: errorMessage)
        }).disposed(by: disposeBag)
    }
    
    func configureRxValidation() {
        let emailStream = emailTextField.rx.text
            .orEmpty
            .skip(1)
            .map { self.isValidEmail(from: $0)}
        
        emailStream.subscribe(
            onNext: { value in
                self.emailErrorLabel.isHidden = value
            }
        ).disposed(by: disposeBag)
        
        let passwordStream = passwordTextField.rx.text
            .orEmpty
            .skip(1)
            .map { self.isValidPassword($0) }
        passwordStream.subscribe(
            onNext: { value in
                self.passwordErrorLabel.isHidden = value
            }
        ).disposed(by: disposeBag)
        
        let validateFieldsStream = Observable.combineLatest(
            emailStream,
            passwordStream
        ) { email, password in
            email && password
        }
        
        validateFieldsStream.subscribe(
            onNext: { isValid in
                self.signInButton.isEnabled = isValid
                self.signInButton.backgroundColor = isValid ? .primary100 : .text100
            }
        ).disposed(by: disposeBag)
    }
    
    private func isValidEmail(from email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let containsNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        let containsSpecialCharacter = texttest.evaluate(with: password)
        return password.count > 8 && containsNumber && containsSpecialCharacter
    }
    
    private func goToDashboard() {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }
        
        let rootController = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        let dashboardViewModel = DashboardViewModel(dashboardUseCase: Injection().provideDashboardUseCase(), userId: viewModel.loginValue?.dataId ?? 0)
        rootController.viewModel = dashboardViewModel
        let navigationController = UINavigationController(rootViewController: rootController)
        let snapshot = firstWindow.snapshotView(afterScreenUpdates: true)!
        navigationController.view.addSubview(snapshot)
        
        firstWindow.rootViewController = navigationController
        
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
    
    // MARK: - Actions
    @objc
    private func checkboxRememberMeButtonTapped() {
        checkboxRememberMeButton.isSelected = !checkboxRememberMeButton.isSelected
    }
    
    @objc
    private func signInButtonTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            LoginKey.stateLogin = checkboxRememberMeButton.isSelected
            viewModel.postLogin(email: email, password: password)
        }
    }
    
    @objc
    private func signUpButtonTapped() {
        let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        let signUpViewModel = SignUpViewModel(signUpUseCase: Injection().provideSignUpUseCase())
        signUpVC.viewModel = signUpViewModel
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc
    private func eyeButtonTapped() {
        if viewModel.isPasswordVisible {
            passwordTextField.isSecureTextEntry = true
            visiblePasswordButton.setImage(UIImage(named: "icon_eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
            viewModel.isPasswordVisible = false
        } else {
            passwordTextField.isSecureTextEntry = false
            visiblePasswordButton.setImage(UIImage(named: "icon_eye_slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
            viewModel.isPasswordVisible = true
        }
    }
}
