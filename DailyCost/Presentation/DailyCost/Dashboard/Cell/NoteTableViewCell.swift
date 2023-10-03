//
//  NoteTableViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 19/09/23.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    func configureContent(body: String?, title: String?, category: String?, createdAt: String?) {
        bodyLabel.text = body
        titleLabel.text = title
        categoryLabel.text = category
        createdAtLabel.text = createdAt
    }
}
