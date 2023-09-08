//
//  DashboardViewController.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import UIKit
import RxSwift

class DashboardViewController: UIViewController {
    @IBOutlet weak var containerCardWallet: UIView!
    @IBOutlet weak var walletCollectionView: UICollectionView!
    @IBOutlet weak var addWalletButton: UIButton!
    @IBOutlet weak var topupButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: DashboardViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonNavBar()
        configureViews()
        initListerner()
        initObserver()
        loadData()
    }
    
    // MARK: - Helpers
    private func loadData() {
        viewModel.getSaldo(id: viewModel.userId)
    }
    
    private func initObserver() {
        viewModel.saldo.drive(onNext: { [weak self] saldo in
            self?.walletCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.drive(onNext: { [weak self] isLoading in
            self?.manageLoadingActivity(isLoading: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel.errorMessage.drive(onNext: { [weak self] errorMessage in
            self?.showErrorSnackBar(message: errorMessage)
        }).disposed(by: disposeBag)
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCollectionViewCell", for: indexPath) as? WalletCollectionViewCell else { return UICollectionViewCell() }
        let depo = viewModel.saldoValue
        cell.configureContent(depo: depo)
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
