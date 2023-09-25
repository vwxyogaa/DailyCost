//
//  CategoryViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 25/09/23.
//

import UIKit

protocol CategoryViewControllerDelegate {
    func categorySelected(_ wallet: Wallet)
}

class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    
    var selectedIndexPath: IndexPath?
    var previouslySelectedCategory: Wallet?
    
    let categories: [Wallet] = [
        Wallet(image: "icon_category_food_drinks", title: "Food & Drinks", subtitle: "", backgroundColor: "systemOrange"),
        Wallet(image: "icon_category_shopping", title: "Shopping", subtitle: "", backgroundColor: "systemPurple"),
        Wallet(image: "icon_category_housing", title: "Housing", subtitle: "", backgroundColor: "systemGreen"),
        Wallet(image: "icon_category_transportation", title: "Transportation", subtitle: "", backgroundColor: "systemOrange"),
        Wallet(image: "icon_category_vehicle", title: "Vehicle", subtitle: "", backgroundColor: "systemPurple"),
        Wallet(image: "icon_category_life_entertainment", title: "Life & Entertaiment", subtitle: "", backgroundColor: "systemGreen"),
        Wallet(image: "icon_category_communication", title: "Communication, PC", subtitle: "", backgroundColor: "systemOrange"),
        Wallet(image: "icon_category_financial_expenses", title: "Financial expenses", subtitle: "", backgroundColor: "systemPurple"),
        Wallet(image: "icon_category_invesments", title: "Invesments", subtitle: "", backgroundColor: "systemGreen"),
        Wallet(image: "icon_category_income", title: "Income", subtitle: "", backgroundColor: "systemOrange"),
        Wallet(image: "icon_category_others", title: "Others", subtitle: "", backgroundColor: "systemPurple"),
    ]
    
    var delegate: CategoryViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
        if let selectedWallet = previouslySelectedCategory,
           let index = categories.firstIndex(where: { $0.title == selectedWallet.title }) {
            selectedIndexPath = IndexPath(row: index, section: 0)
        }
    }
    
    // MARK: - Helpers
    private func configureViews() {
        title = "Category"
        
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        
        if indexPath == selectedIndexPath {
            cell.accessoryView = UIImageView(image: UIImage(named: "icon_tick"))
        } else {
            cell.accessoryView = nil
        }
        
        let wallet = categories[indexPath.row]
        cell.iconImageView.image = UIImage(named: wallet.image ?? "")
        cell.titleLabel.text = wallet.title
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        delegate?.categorySelected(categories[indexPath.row])
        
        var indexPathsToReload: [IndexPath] = [indexPath]
        if let previous = previousIndexPath {
            indexPathsToReload.append(previous)
        }
        
        tableView.reloadRows(at: indexPathsToReload, with: .none)
    }
}
