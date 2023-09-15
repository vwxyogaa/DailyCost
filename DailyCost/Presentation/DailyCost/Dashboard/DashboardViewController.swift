//
//  DashboardViewController.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import UIKit
import RxSwift

class DashboardViewController: UIViewController {
    @IBOutlet weak var mainFloatingButton: UIButton!
    @IBOutlet weak var clueCloseContainerView: UIView!
    @IBOutlet weak var clueCloseView: UIView!
    @IBOutlet weak var newActivityButton: UIButton!
    @IBOutlet weak var clueNewActivityContainerView: UIView!
    @IBOutlet weak var clueNewActivityView: UIView!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var clueNotesContainerView: UIView!
    @IBOutlet weak var clueNotesView: UIView!
    @IBOutlet weak var containerCardWallet: UIView!
    @IBOutlet weak var walletCollectionView: UICollectionView!
    @IBOutlet weak var addWalletButton: UIButton!
    @IBOutlet weak var topupButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var recentlyActivityTableView: UITableView!
    @IBOutlet weak var recentlyActivityTableViewHeightConstraint: NSLayoutConstraint! { didSet {
        recentlyActivityTableViewHeightConstraint.activated()
    }}
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentlyActivityTableView.addObserver(self, forKeyPath: UITableView.contentSizeKeyPath, options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        recentlyActivityTableView.removeObserver(self, forKeyPath: UITableView.contentSizeKeyPath, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newValue = change?[.newKey], keyPath == UITableView.contentSizeKeyPath {
            let size = newValue as! CGSize
            updateTableViewContentSize(size: size.height)
        }
    }
    
    // MARK: - Helpers
    private func loadData() {
        viewModel.getSaldo(id: viewModel.userId)
        viewModel.getPengeluaran(id: viewModel.userId)
    }
    
    private func initObserver() {
        viewModel.saldo.drive(onNext: { [weak self] saldo in
            self?.walletCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.spending.drive(onNext: { [weak self] spending in
            self?.walletCollectionView.reloadData()
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
        containerCardWallet.layer.cornerRadius = 18
        containerCardWallet.layer.masksToBounds = true
        
        walletCollectionView.register(UINib(nibName: "WalletCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WalletCollectionViewCell")
        walletCollectionView.dataSource = self
        walletCollectionView.delegate = self
        
        clueCloseView.layer.cornerRadius = 7
        clueCloseView.layer.masksToBounds = true
        clueNewActivityView.layer.cornerRadius = 7
        clueNewActivityView.layer.masksToBounds = true
        clueNotesView.layer.cornerRadius = 7
        clueNotesView.layer.masksToBounds = true
        
        mainFloatingButton.setTitle("", for: .normal)
        mainFloatingButton.setImage(UIImage(named: "icon_add"), for: .normal)
        mainFloatingButton.layer.cornerRadius = mainFloatingButton.frame.height / 2
        mainFloatingButton.layer.masksToBounds = true
        
        newActivityButton.setTitle("", for: .normal)
        newActivityButton.setImage(UIImage(named: "icon_edit"), for: .normal)
        newActivityButton.layer.cornerRadius = newActivityButton.frame.height / 2
        newActivityButton.layer.masksToBounds = true
        
        notesButton.setTitle("", for: .normal)
        notesButton.setImage(UIImage(named: "icon_book"), for: .normal)
        notesButton.layer.cornerRadius = notesButton.frame.height / 2
        notesButton.layer.masksToBounds = true
        
        clueCloseContainerView.alpha = 0
        newActivityButton.alpha = 0
        clueNewActivityContainerView.alpha = 0
        notesButton.alpha = 0
        clueNotesContainerView.alpha = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        recentlyActivityTableView.register(UINib(nibName: "RecentlyActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentlyActivityTableViewCell")
        recentlyActivityTableView.dataSource = self
        recentlyActivityTableView.delegate = self
    }
    
    private func initListerner() {
        mainFloatingButton.addTarget(self, action: #selector(mainFloatingButtonTapped), for: .touchUpInside)
        newActivityButton.addTarget(self, action: #selector(newActivityButtonTapped), for: .touchUpInside)
        notesButton.addTarget(self, action: #selector(notesButtonTapped), for: .touchUpInside)
        
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
    
    private func updateTableViewContentSize(size: CGFloat) {
        recentlyActivityTableViewHeightConstraint.constant = size
    }
    
    // MARK: - Actions
    @objc
    private func viewTapped(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        
        if !mainFloatingButton.frame.contains(location) && !newActivityButton.frame.contains(location) && !notesButton.frame.contains(location) && viewModel.isOpen {
            mainFloatingButtonTapped()
        }
    }
    
    @objc
    private func mainFloatingButtonTapped() {
        viewModel.isOpen.toggle()
        
        UIView.animate(withDuration: 0.3) {
            if self.viewModel.isOpen {
                self.mainFloatingButton.setImage(UIImage(named: "icon_close"), for: .normal)
                self.clueCloseContainerView.alpha = 1
                self.newActivityButton.alpha = 1
                self.clueNewActivityContainerView.alpha = 1
                self.notesButton.alpha = 1
                self.clueNotesContainerView.alpha = 1
            } else {
                self.mainFloatingButton.setImage(UIImage(named: "icon_add"), for: .normal)
                self.clueCloseContainerView.alpha = 0
                self.newActivityButton.alpha = 0
                self.clueNewActivityContainerView.alpha = 0
                self.notesButton.alpha = 0
                self.clueNotesContainerView.alpha = 0
            }
        }
    }
    
    @objc
    private func newActivityButtonTapped() {
        showSuccessSnackBar(message: "New activity button tapped!")
    }
    
    @objc
    private func notesButtonTapped() {
        showSuccessSnackBar(message: "Notes button tapped!")
    }
    
    @objc
    private func leftButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        let drawerMenuViewController = DrawerMenuViewController()
        present(drawerMenuViewController, animated: true)
    }
    
    @objc
    private func rightButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        showSuccessSnackBar(message: "Notification Button Clicked!")
    }
    
    @objc
    private func addWalletButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        showSuccessSnackBar(message: "Add wallet Button Clicked!")
    }
    
    @objc
    private func topupButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        showSuccessSnackBar(message: "Top up Button Clicked!")
    }
    
    @objc
    private func moreButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        showSuccessSnackBar(message: "More Button Clicked!")
    }
    
    @objc
    private func seeAllButtonTapped() {
        showSuccessSnackBar(message: "See all Button Clicked!")
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
        let spending = viewModel.spendingValue
        cell.configureContent(depo: depo, spending: spending)
        cell.delegate = self
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

// MARK: - WalletCollectionViewCellDelegate
extension DashboardViewController: WalletCollectionViewCellDelegate {
    func eyeButtonWasTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.spendingValue?.dataResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlyActivityTableViewCell", for: indexPath) as? RecentlyActivityTableViewCell else { return UITableViewCell() }
        let spending = viewModel.spendingValue?.dataResults?[indexPath.row]
        cell.configureContent(spending: spending)
        cell.containerViewTopConstraint.constant = indexPath.row == 0 ? 0 : 12
        cell.containerViewBottomConstraint.constant = indexPath.row == (viewModel.spendingValue?.dataResults?.count ?? 0) - 1 ? 0 : 12
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recently activity"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .text200
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        let seeAllButton = UIButton()
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setTitleColor(.text200, for: .normal)
        let chevronImage = UIImage(named: "icon_arrow_right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        seeAllButton.setImage(chevronImage, for: .normal)
        seeAllButton.semanticContentAttribute = .forceRightToLeft
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        headerView.addSubview(seeAllButton)
        
        NSLayoutConstraint.activate([
            seeAllButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
