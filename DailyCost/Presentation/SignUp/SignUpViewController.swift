//
//  SignUpViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var termServiceButton: UIButton!
    
    // MARK: - Views
    private lazy var visiblePasswordButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "icon_eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .text200
        button.setTitle("", for: .normal)
        return button
    }()
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var viewModel: SignUpViewModel!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
        initListener()
        configureRxValidation()
        initObserver()
    }
    
    // MARK: - Methods
    private func configureViews() {
        usernameTextField.layer.borderColor = UIColor.bg200.cgColor
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.cornerRadius = 9
        usernameTextField.layer.masksToBounds = true
        
        emailTextField.layer.borderColor = UIColor.bg200.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 9
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.borderColor = UIColor.bg200.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 9
        passwordTextField.layer.masksToBounds = true
        passwordTextField.setRightViewButton(visiblePasswordButton, padding: 16)
        
        signUpButton.layer.cornerRadius = 12
        signUpButton.layer.masksToBounds = true
        
        usernameErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
    
    private func initListener() {
        visiblePasswordButton.addTarget(self, action: #selector(self.eyeButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    private func initObserver() {
        viewModel.register.drive(onNext: { [weak self] register in
            if register != nil {
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
        let usernameStream = usernameTextField.rx.text
            .orEmpty
            .skip(1)
            .map { !$0.isEmpty }
        usernameStream.subscribe(
            onNext: { value in
                self.usernameErrorLabel.isHidden = value
            }
        ).disposed(by: disposeBag)
        
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
            usernameStream,
            emailStream,
            passwordStream
        ) { username, email, password in
            username && email && password
        }
        
        validateFieldsStream.subscribe(
            onNext: { isValid in
                self.signUpButton.isEnabled = isValid
                self.signUpButton.backgroundColor = isValid ? .primary100 : .text100
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
        let dashboardViewModel = DashboardViewModel(dashboardUseCase: Injection().provideDashboardUseCase(), userId: viewModel.registerValue?.dataId ?? 0)
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
    private func signUpButtonTapped() {
        if let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.postRegister(name: username, email: email, password: password)
        }
    }
    
    @objc
    private func signInButtonTapped() {
        let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
        let signInViewModel = SignInViewModel(signInUseCase: Injection().provideSignInUseCase())
        signInVC.viewModel = signInViewModel
        navigationController?.pushViewController(signInVC, animated: true)
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
