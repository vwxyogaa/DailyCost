//
//  WalletCollectionViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

import UIKit

// MARK: - Protocols
protocol WalletCollectionViewCellDelegate {
    func eyeButtonWasTapped()
}

class WalletCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var containerWalletView: UIView!
    @IBOutlet weak var titleWalletLabel: UILabel!
    @IBOutlet weak var balanceWalletLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var expenseWalletLabel: UILabel!
    
    // MARK: - Properties
    var delegate: WalletCollectionViewCellDelegate?
    private var currentData: DepoModel?
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    // MARK: - Methods
    private func configureViews() {
        containerWalletView.layer.cornerRadius = 15
        containerWalletView.layer.shadowOpacity = 0.1
        containerWalletView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerWalletView.layer.shadowRadius = 5
        containerWalletView.backgroundColor = .systemOrange
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    func configureContent(depo: DepoModel?, spending: ExpenseModel?) {
        currentData = depo

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."

        let balance = depo?.dataUangRekening ?? 0
        titleWalletLabel.text = "Uang Rekening"
        let secureText = String(repeating: "•", count: String(format: "%.0f", balance).count)
        balanceWalletLabel.text = "Rp \(secureText)"
        
        let spendingAmount = spending?.pengeluaranRekening ?? 0
        let spendingString = numberFormatter.string(from: NSNumber(value: spendingAmount)) ?? "0"
        expenseWalletLabel.text = "Monthly expenses Rp \(spendingString)"
    }
    
    // MARK: - Actions
    @objc
    private func eyeButtonTapped() {
        eyeButton.isSelected = !eyeButton.isSelected

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."

        if eyeButton.isSelected, let balance = currentData?.dataUangRekening {
            let balanceString = numberFormatter.string(from: NSNumber(value: balance)) ?? "0"
            balanceWalletLabel.text = "Rp \(balanceString)"
        } else if let balance = currentData?.dataUangRekening {
            let secureText = String(repeating: "•", count: String(format: "%.0f", balance).count)
            balanceWalletLabel.text = "Rp \(secureText)"
        }
        
        delegate?.eyeButtonWasTapped()
    }
}
