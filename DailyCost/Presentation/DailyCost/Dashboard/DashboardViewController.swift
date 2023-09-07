//
//  DashboardViewController.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var containerCardWallet: UIView!
    @IBOutlet weak var walletCollectionView: UICollectionView!
    @IBOutlet weak var addWalletButton: UIButton!
    @IBOutlet weak var topupButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    private var cardDatas: [CardData] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonNavBar()
        loadDataFromAPI()
        configureViews()
        initListerner()
    }
    
    // MARK: - Helpers
    private func loadDataFromAPI() {
        cardDatas = [
            CardData(title: "Subscribtion’s wallet", balance: "3.000.000.000", monthlyExpense: "100.000"),
            CardData(title: "E-Wallet", balance: "500.000", monthlyExpense: "250.000"),
            CardData(title: "Bank Account", balance: "900.000", monthlyExpense: "500.000")
        ]
    }
    
    private func configureViews() {
        containerCardWallet.layer.cornerRadius = 18
        containerCardWallet.layer.masksToBounds = true
        
        walletCollectionView.register(UINib(nibName: "WalletCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WalletCollectionViewCell")
        walletCollectionView.dataSource = self
        walletCollectionView.delegate = self
    }
    
    private func initListerner() {
        addWalletButton.addTarget(self, action: #selector(addWalletButtonTapped), for: .touchUpInside)
        topupButton.addTarget(self, action: #selector(topupButtonTapped), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    private func configureButtonNavBar() {
        let leftImage = UIImage(named: "icon_dashboard")?.withRenderingMode(.alwaysOriginal)
        let leftButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.leftBarButtonItem = leftButton
        
        let rightImage = UIImage(named: "icon_notification")?.withRenderingMode(.alwaysOriginal)
        let rightButton = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: - Actions
    @objc
    private func leftButtonTapped() {
        showSuccessSnackBar(message: "Dashboard Button Clicked!")
    }
    
    @objc
    private func rightButtonTapped() {
        showSuccessSnackBar(message: "Notification Button Clicked!")
    }
    
    @objc
    private func addWalletButtonTapped() {
        showSuccessSnackBar(message: "Add wallet Button Clicked!")
    }
    
    @objc
    private func topupButtonTapped() {
        showSuccessSnackBar(message: "Top up Button Clicked!")
    }
    
    @objc
    private func moreButtonTapped() {
        showSuccessSnackBar(message: "More Button Clicked!")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCollectionViewCell", for: indexPath) as? WalletCollectionViewCell else { return UICollectionViewCell() }
        cell.configureContent(with: cardDatas[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width
        let heightPerItem: CGFloat = 118
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
