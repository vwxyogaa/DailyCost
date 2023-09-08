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
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    func configureContent(depo: DepoModel?) {
        currentData = depo
        
        titleWalletLabel.text = String(depo?.dataUangRekening ?? 0) 
        let secureText = String(repeating: "•", count: Int(depo?.dataUangRekening ?? 0))
        balanceWalletLabel.text = "Rp \(secureText)"
        expenseWalletLabel.text = "Monthly expenses Rp \(depo?.dataUangRekening ?? 0)"
    }
    
    // MARK: - Actions
    @objc
    private func eyeButtonTapped() {
        eyeButton.isSelected = !eyeButton.isSelected
        
        if eyeButton.isSelected, let balance = currentData?.dataUangRekening {
            balanceWalletLabel.text = "Rp \(balance)"
        } else if let secureLength = currentData?.dataUangRekening {
            let secureText = String(repeating: "•", count: Int(secureLength))
            balanceWalletLabel.text = "Rp \(secureText)"
        }
        
        delegate?.eyeButtonWasTapped()
    }
}
