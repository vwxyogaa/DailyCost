//
//  NewActivityViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 22/09/23.
//

import UIKit

class NewActivityViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var containerSegmentedControl: UIView!
    @IBOutlet weak var typeFinanceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var walletTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    // MARK: - Properties
    var selectedWallet: Wallet?
    var selectedCategory: Wallet?
    var datePicker = UIDatePicker()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
        configureTextField()
        configureDatePicker()
    }
    
    // MARK: - Methods
    private func configureViews() {
        title = "New Activity"
        
        let tickImage = UIImage(named: "icon_tick")?.withRenderingMode(.alwaysOriginal)
        let saveButton = UIBarButtonItem(image: tickImage, style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveButton
        
        containerSegmentedControl.layer.cornerRadius = 12
        containerSegmentedControl.layer.masksToBounds = true
        
        let selectedTitleAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white]
        typeFinanceSegmentedControl.setTitleTextAttributes(selectedTitleAttributes, for: .selected)
        
        let normalTitleAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.black]
        typeFinanceSegmentedControl.setTitleTextAttributes(normalTitleAttributes, for: .normal)
        
        let dateIcon = UIImageView()
        dateIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        dateIcon.image = UIImage(named: "icon_calendar")
        dateIcon.contentMode = .scaleAspectFit
        dateTextField.setRightView(dateIcon)
    }
    
    private func configureTextField() {
        titleTextField.delegate = self
        walletTextField.delegate = self
        categoryTextField.delegate = self
        dateTextField.delegate = self
        amountTextField.delegate = self
    }
    
    private func configureDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        datePicker.locale = Constants.DefaultLocale
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        dateTextField.inputView = datePicker
    }
    
    // MARK: - Actions
    @objc
    private func saveButtonTapped() {
        if titleTextField.text?.isEmpty ?? true {
            showErrorSnackBar(message: "Add a title first.")
            return
        }
        
        if walletTextField.text?.isEmpty ?? true {
            showErrorSnackBar(message: "Add a wallet.")
            return
        }
        
        if categoryTextField.text?.isEmpty ?? true {
            showErrorSnackBar(message: "Add a category.")
            return
        }
        
        if dateTextField.text?.isEmpty ?? true {
            showErrorSnackBar(message: "Add a date.")
            return
        }
        
        if amountTextField.text?.isEmpty ?? true {
            showErrorSnackBar(message: "Add an amount first.")
            return
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc
    private func datePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Constants.DefaultLocale
        dateTextField.text = dateFormatter.string(from: picker.date)
    }
}

// MARK: - UITextFieldDelegate
extension NewActivityViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case titleTextField:
            return true
        case walletTextField:
            let walletViewController = WalletViewController()
            walletViewController.delegate = self
            walletViewController.previouslySelectedWallet = selectedWallet
            self.navigationController?.pushViewController(walletViewController, animated: true)
            self.view.endEditing(true)
            return false
        case categoryTextField:
            let categoryViewController = CategoryViewController()
            categoryViewController.delegate = self
            categoryViewController.previouslySelectedCategory = selectedCategory
            self.navigationController?.pushViewController(categoryViewController, animated: true)
            self.view.endEditing(true)
            return false
        case dateTextField:
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Constants.DefaultLocale
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if dateTextField.text?.isEmpty ?? true {
                dateTextField.text = dateFormatter.string(from: Date())
            } else if let date = dateFormatter.date(from: textField.text ?? "") {
                datePicker.date = date
            }
            return true
        case amountTextField:
            return true
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case titleTextField:
            return true
        case walletTextField:
            let walletViewController = WalletViewController()
            self.navigationController?.pushViewController(walletViewController, animated: true)
            return false
        case categoryTextField:
            let categoryViewController = CategoryViewController()
            self.navigationController?.pushViewController(categoryViewController, animated: true)
            return false
        case dateTextField:
            return true
        case amountTextField:
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 13
        default:
            break
        }
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if dateTextField.isFirstResponder {
            DispatchQueue.main.async(execute: {
                (sender as? UIMenuController)?.hideMenu()
            })
            return false
        }
        return true
    }
}

// MARK: - WalletViewControllerDelegate
extension NewActivityViewController: WalletViewControllerDelegate {
    func walletSelected(_ wallet: Wallet) {
        walletTextField.text = wallet.title
        selectedWallet = wallet
    }
}

// MARK: - CategoryViewControllerDelegate
extension NewActivityViewController: CategoryViewControllerDelegate {
    func categorySelected(_ wallet: Wallet) {
        categoryTextField.text = wallet.title
        selectedCategory = wallet
    }
}
