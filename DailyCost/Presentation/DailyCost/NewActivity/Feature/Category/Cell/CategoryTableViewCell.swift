//
//  CategoryTableViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 25/09/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var containerIconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    private func configureViews() {
        containerIconView.layer.cornerRadius = 20
        containerIconView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
