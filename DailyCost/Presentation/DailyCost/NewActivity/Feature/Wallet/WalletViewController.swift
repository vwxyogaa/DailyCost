//
//  WalletViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 25/09/23.
//

import UIKit

protocol WalletViewControllerDelegate {
    func walletSelected(_ wallet: Wallet)
}

class WalletViewController: UIViewController {
    @IBOutlet weak var walletTableView: UITableView!
    
    var selectedIndexPath: IndexPath?
    var previouslySelectedWallet: Wallet?
    
    let wallets: [Wallet] = [
        Wallet(image: "icon_empty_wallet", title: "Subscriptions", subtitle: "General", backgroundColor: "systemOrange"),
        Wallet(image: "icon_wallet_loan", title: "Saving", subtitle: "Loan", backgroundColor: "systemPurple"),
        Wallet(image: "icon_coin", title: "Investasi rumah", subtitle: "Invest", backgroundColor: "systemGreen")
    ]
    
    var delegate: WalletViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
        if let selectedWallet = previouslySelectedWallet,
           let index = wallets.firstIndex(where: { $0.title == selectedWallet.title }) {
            selectedIndexPath = IndexPath(row: index, section: 0)
        }
    }
    
    // MARK: - Helpers
    private func configureViews() {
        title = "Wallet"
        
        walletTableView.register(UINib(nibName: "WalletTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletTableViewCell")
        walletTableView.dataSource = self
        walletTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension WalletViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as? WalletTableViewCell else { return UITableViewCell() }
        
        if indexPath == selectedIndexPath {
            cell.accessoryView = UIImageView(image: UIImage(named: "icon_tick"))
        } else {
            cell.accessoryView = nil
        }
        
        let wallet = wallets[indexPath.row]
        cell.iconImageView.image = UIImage(named: wallet.image ?? "")
        cell.titleLabel.text = wallet.title
        cell.subtitleLabel.text = wallet.subtitle
        
        if let colorName = wallet.backgroundColor {
            var backgroundColor: UIColor? = nil
            
            switch colorName {
            case "systemOrange":
                backgroundColor = UIColor.systemOrange
            case "systemPurple":
                backgroundColor = UIColor.systemPurple
            case "systemGreen":
                backgroundColor = UIColor.systemGreen
            default:
                backgroundColor = UIColor.systemOrange
            }
            
            cell.containerIconView.backgroundColor = backgroundColor
        }
        
        cell.containerViewTopConstraint.constant = indexPath.row == 0 ? 6 : 6
        cell.containerViewBottomConstraint.constant = indexPath.row == wallets.count - 1 ? 6 : 6
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        delegate?.walletSelected(wallets[indexPath.row])
        
        var indexPathsToReload: [IndexPath] = [indexPath]
        if let previous = previousIndexPath {
            indexPathsToReload.append(previous)
        }
        
        tableView.reloadRows(at: indexPathsToReload, with: .none)
    }
}
