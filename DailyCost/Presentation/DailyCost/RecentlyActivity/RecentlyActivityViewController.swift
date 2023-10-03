//
//  RecentlyActivityViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 22/09/23.
//

import UIKit
import RxSwift

class RecentlyActivityViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var recentlyActivityTableView: UITableView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var viewModel: RecentlyActivityViewModel!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
        initObserver()
        loadData()
    }
    
    // MARK: - Methods
    private func loadData() {
        viewModel.getPengeluaran(id: viewModel.userId)
    }
    
    private func initObserver() {
        viewModel.recentlyActivity.drive(onNext: { [weak self] recentlyActivity in
            if recentlyActivity != nil {
                self?.recentlyActivityTableView.isHidden = false
            } else {
                self?.recentlyActivityTableView.isHidden = true
            }
            self?.recentlyActivityTableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.drive(onNext: { [weak self] isLoading in
            self?.manageLoadingActivity(isLoading: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel.errorMessage.drive(onNext: { [weak self] errorMessage in
            self?.showErrorSnackBar(message: errorMessage)
        }).disposed(by: disposeBag)
    }
    
    private func configureViews() {
        title = "Recently Activity"
        
        recentlyActivityTableView.register(UINib(nibName: "RecentlyActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentlyActivityTableViewCell")
        recentlyActivityTableView.dataSource = self
        recentlyActivityTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension RecentlyActivityViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.activitiesByDate.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedKeys = Array(viewModel.activitiesByDate.keys).sorted(by: >)
        if let key = sortedKeys[safe: section] {
            return viewModel.activitiesByDate[key]?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlyActivityTableViewCell", for: indexPath) as? RecentlyActivityTableViewCell else { return UITableViewCell() }
        let sortedKeys = Array(viewModel.activitiesByDate.keys).sorted(by: >)
        if let key = sortedKeys[safe: indexPath.section],
           let activity = viewModel.activitiesByDate[key]?[indexPath.row] {
            cell.configureContent(
                name: activity.name,
                date: activity.date,
                category: activity.category,
                total: activity.amount,
                type: activity.type
            )
            cell.containerViewTopConstraint.constant = indexPath.row == 0 ? 0 : 12
            cell.containerViewBottomConstraint.constant = indexPath.row == (viewModel.expenseValue?.userId?.count ?? 0) - 1 ? 0 : 12
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sortedKeys = Array(viewModel.activitiesByDate.keys).sorted(by: >)
        let date = sortedKeys[safe: section] ?? ""
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.serverDate.rawValue
        let currentDateString = dateFormatter.string(from: Date())
        if date == currentDateString {
            label.text = "Today"
        } else {
            let dateConvert = date.convertDateString(fromFormat: .serverDate, toFormat: .fullDayDateMonthYear) ?? "-"
            label.text = dateConvert
        }
        
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .text200
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
