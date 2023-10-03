//
//  WalletTableViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 25/09/23.
//

import UIKit

class WalletTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var containerIconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
