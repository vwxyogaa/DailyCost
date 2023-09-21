//
//  NotesTableViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 21/09/23.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var categoryCashFlowLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
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
    }
}
