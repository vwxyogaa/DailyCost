//
//  WalletCollectionViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

import UIKit

protocol WalletCollectionViewCellDelegate {
    func eyeButtonWasTapped()
}

class WalletCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerWalletView: UIView!
    @IBOutlet weak var titleWalletLabel: UILabel!
    @IBOutlet weak var balanceWalletLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var expenseWalletLabel: UILabel!
    
    var delegate: WalletCollectionViewCellDelegate?
    private var currentData: DepoModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    private func configureViews() {
        containerWalletView.layer.cornerRadius = 15
        containerWalletView.layer.shadowOpacity = 0.1
        containerWalletView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerWalletView.layer.shadowRadius = 5
        containerWalletView.backgroundColor = .systemOrange
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    func configureContent(depo: DepoModel?, spending: SpendingModel?) {
        currentData = depo
        
        let balanceString = String(format: "%.0f", depo?.dataUangRekening ?? 0)
        titleWalletLabel.text = "Uang Rekening"
        let secureText = String(repeating: "•", count: balanceString.count)
        balanceWalletLabel.text = "Rp \(secureText)"
        expenseWalletLabel.text = "Monthly expenses Rp \(spending?.dataPengeluaran?.pengeluaranRekening ?? 0)"
    }
    
    // MARK: - Actions
    @objc
    private func eyeButtonTapped() {
        eyeButton.isSelected = !eyeButton.isSelected
        
        if eyeButton.isSelected, let balance = currentData?.dataUangRekening {
            let balanceString = String(format: "%.0f", balance)
            balanceWalletLabel.text = "Rp \(balanceString)"
        } else if let balance = currentData?.dataUangRekening {
            let balanceString = String(format: "%.0f", balance)
            let secureText = String(repeating: "•", count: balanceString.count)
            balanceWalletLabel.text = "Rp \(secureText)"
        }
        
        delegate?.eyeButtonWasTapped()
    }
}
