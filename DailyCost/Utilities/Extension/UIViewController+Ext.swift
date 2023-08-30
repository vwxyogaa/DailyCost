//
//  UIViewController+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

// MARK: - Back Button No Text
extension UIViewController {
    var shouldHideBackButtonText: Bool {
        get {
            return false
        }
        set {
            if newValue {
                let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
                navigationController?.navigationBar.tintColor = .text200
            } else {
                navigationController?.navigationBar.tintColor = .systemBlue
            }
        }
    }
}

// MARK: - Loading View
extension UIViewController {
    func manageLoadingActivity(isLoading: Bool) {
        if isLoading {
            showLoadingActivity()
        } else {
            hideLoadingActivity()
        }
    }
    
    func showLoadingActivity() {
        self.view.makeToastActivity(.center)
    }
    
    func hideLoadingActivity() {
        self.view.hideToastActivity()
    }
}

// MARK: - Toast
var snackBarExt: TTGSnackbar?
extension UIViewController {
    func showErrorSnackBar(message: String?) {
        guard let errorMessage = message else { return }
        snackBarExt?.dismiss()
        snackBarExt = TTGSnackbar(message: errorMessage, duration: .short)
        snackBarExt?.duration = .middle
        snackBarExt?.shouldDismissOnSwipe = true
        snackBarExt?.backgroundColor = .systemRed
        snackBarExt?.actionTextNumberOfLines = 0
        snackBarExt?.show()
    }
    
    func showSuccessSnackBar(message: String?) {
        guard let successMessage = message else { return }
        snackBarExt?.dismiss()
        snackBarExt = TTGSnackbar(message: successMessage, duration: .short)
        snackBarExt?.duration = .middle
        snackBarExt?.shouldDismissOnSwipe = true
        snackBarExt?.backgroundColor = .systemGreen
        snackBarExt?.actionTextNumberOfLines = 0
        snackBarExt?.show()
    }
}
