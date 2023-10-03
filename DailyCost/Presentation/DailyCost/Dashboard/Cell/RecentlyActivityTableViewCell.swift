//
//  RecentlyActivityTableViewCell.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import UIKit

class RecentlyActivityTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    func configureViews() {
        iconImageView.backgroundColor = .systemOrange
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.layer.masksToBounds = true
    }
    
    func configureContent(name: String?, date: String?, category: String?, total: Int?, type: ActivityType) {
        nameLabel.text = name ?? "-"
        
        let dateConvert = date?.convertDateString(fromFormat: .serverDate, toFormat: .weekDayDateMonthYear) ?? "-"
        dateLabel.text = dateConvert
        
        if let kategori = category, !kategori.isEmpty {
            let firstLetterCapitalized = kategori.prefix(1).uppercased() + kategori.dropFirst()
            categoryLabel.text = firstLetterCapitalized
        } else {
            categoryLabel.text = "-"
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        
        let spendingAmount = total ?? 0
        let spendingString = numberFormatter.string(from: NSNumber(value: spendingAmount)) ?? "0"
        if type == .income {
            totalLabel.textColor = .accent100
            totalLabel.text = "+Rp\(spendingString)"
        } else {
            totalLabel.textColor = .accent300
            totalLabel.text = "-Rp\(spendingString)"
        }
    }
}
