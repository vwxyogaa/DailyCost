//
//  NotificationViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 21/09/23.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var notificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
    }
    
    private func configureViews() {
        title = "Notification"
        
        notificationTableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        notificationTableView.dataSource = self
        notificationTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as? NotificationTableViewCell else { return UITableViewCell() }
        return cell
    }
}
