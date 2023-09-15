//
//  RecentlyActivityTableViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import UIKit

class RecentlyActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureViews() {
        iconImageView.backgroundColor = .systemOrange
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.layer.masksToBounds = true
    }
    
    func configureContent(spending: SpendingModel.Result?) {
        nameLabel.text = spending?.nama ?? "-"
        let date = spending?.tanggal?.convertDateString(fromFormat: .dayMonthYearWithTimeV2, toFormat: .weekDayDateMonthYear) ?? "-"
        dateLabel.text = date
        categoryLabel.text = spending?.kategori ?? "-"
        totalLabel.text = "-Rp\(spending?.jumlah ?? 0)"
    }
}
