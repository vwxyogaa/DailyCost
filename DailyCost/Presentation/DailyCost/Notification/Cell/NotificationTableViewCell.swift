//
//  NotificationTableViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 21/09/23.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureViews() {
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.layer.masksToBounds = true
    }
}
