//
//  WalletCollectionViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

import UIKit

class WalletCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerWalletView: UIView!
    @IBOutlet weak var titleWalletLabel: UILabel!
    @IBOutlet weak var balanceWalletLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var expenseWalletLabel: UILabel!
    
    private var currentData: CardData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    private func configureViews() {
        containerWalletView.layer.cornerRadius = 15
        containerWalletView.layer.shadowOpacity = 0.1
        containerWalletView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerWalletView.layer.shadowRadius = 5
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    func configureContent(with data: CardData) {
        currentData = data
        
        containerWalletView.backgroundColor = backgroundColor(forTitle: data.title)
        titleWalletLabel.text = data.title
        let secureText = String(repeating: "•", count: data.balance?.count ?? 0)
        balanceWalletLabel.text = "Rp \(secureText)"
        expenseWalletLabel.text = "Monthly expenses Rp \(data.monthlyExpense ?? "0")"
    }
    
    private func backgroundColor(forTitle title: String?) -> UIColor {
        switch title {
        case "Subscribtion’s wallet":
            return UIColor.systemOrange
        case "E-Wallet":
            return UIColor.systemGreen
        case "Bank Account":
            return UIColor.systemBlue
        default:
            return UIColor.systemGray
        }
    }
    
    // MARK: - Actions
    @objc
    private func eyeButtonTapped() {
        eyeButton.isSelected = !eyeButton.isSelected
        
        if eyeButton.isSelected, let balance = currentData?.balance {
            balanceWalletLabel.text = "Rp \(balance)"
        } else if let secureLength = currentData?.balance?.count {
            let secureText = String(repeating: "•", count: secureLength)
            balanceWalletLabel.text = "Rp \(secureText)"
        }
    }
}
