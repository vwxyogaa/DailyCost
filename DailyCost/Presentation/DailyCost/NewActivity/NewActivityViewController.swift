//
//  NewActivityViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 22/09/23.
//

import UIKit

class NewActivityViewController: UIViewController {
    @IBOutlet weak var containerSegmentedControl: UIView!
    @IBOutlet weak var typeFinanceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
    }
    
    // MARK: - Helpers
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
    
    // MARK: - Actions
    @objc
    private func saveButtonTapped() {
        showSuccessSnackBar(message: "Save Button Clicked!")
    }
}
