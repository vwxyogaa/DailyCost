//
//  SignUpViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

class SignUpViewController: UIViewController {
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
    
    var isPasswordVisible: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
        initListener()
    }
    
    // MARK: - Helpers
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
    }
    
    private func initListener() {
        visiblePasswordButton.addTarget(self, action: #selector(self.eyeButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func signInButtonTapped() {
        let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc
    private func eyeButtonTapped() {
        if isPasswordVisible {
            passwordTextField.isSecureTextEntry = true
            visiblePasswordButton.setImage(UIImage(named: "icon_eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
            isPasswordVisible = false
        } else {
            passwordTextField.isSecureTextEntry = false
            visiblePasswordButton.setImage(UIImage(named: "icon_eye_slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
            isPasswordVisible = true
        }
    }
}
