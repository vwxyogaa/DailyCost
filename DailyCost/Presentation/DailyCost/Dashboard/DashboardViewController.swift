//
//  DashboardViewController.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import UIKit
import RxSwift

class DashboardViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
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
    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var noteTableViewHeightConstraint: NSLayoutConstraint!
    
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
        noteTableView.addObserver(self, forKeyPath: UITableView.contentSizeKeyPath, options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        recentlyActivityTableView.removeObserver(self, forKeyPath: UITableView.contentSizeKeyPath, context: nil)
        noteTableView.removeObserver(self, forKeyPath: UITableView.contentSizeKeyPath, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newValue = change?[.newKey], keyPath == UITableView.contentSizeKeyPath {
            let size = newValue as! CGSize
            if object as? UITableView == recentlyActivityTableView {
                updateTableViewContentSize(tableView: recentlyActivityTableView, size: size.height)
            } else if object as? UITableView == noteTableView {
                updateTableViewContentSize(tableView: noteTableView, size: size.height)
            }
        }
    }
    
    // MARK: - Helpers
    private func loadData() {
        viewModel.getSaldo(id: viewModel.userId)
        viewModel.getPengeluaran(id: viewModel.userId)
        viewModel.getCatatan(id: viewModel.userId)
    }
    
    private func initObserver() {
        viewModel.balance.drive(onNext: { [weak self] saldo in
            self?.walletCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.recentlyActivity.drive(onNext: { [weak self] recentlyActivity in
            if recentlyActivity != nil {
                self?.recentlyActivityTableView.isHidden = false
            } else {
                self?.recentlyActivityTableView.isHidden = true
            }
            self?.walletCollectionView.reloadData()
            self?.recentlyActivityTableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.catatan.drive(onNext: { [weak self] catatan in
            if let catatan, catatan.catatanId?.count != 0 {
                self?.noteTableView.isHidden = false
            } else {
                self?.noteTableView.isHidden = true
            }
            self?.noteTableView.reloadData()
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
        
        clueCloseContainerView.isHidden = true
        newActivityButton.isHidden = true
        clueNewActivityContainerView.isHidden = true
        notesButton.isHidden = true
        clueNotesContainerView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        recentlyActivityTableView.register(UINib(nibName: "RecentlyActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentlyActivityTableViewCell")
        recentlyActivityTableView.dataSource = self
        recentlyActivityTableView.delegate = self
        
        scrollView.delegate = self
        
        noteTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        noteTableView.dataSource = self
        noteTableView.delegate = self
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
        let dashboardImage = UIImage(named: "icon_dashboard")?.withRenderingMode(.alwaysOriginal)
        let dashboardButton = UIBarButtonItem(image: dashboardImage, style: .plain, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.leftBarButtonItem = dashboardButton
        
        let notificationImage = UIImage(named: "icon_notification")?.withRenderingMode(.alwaysOriginal)
        let notificationButton = UIBarButtonItem(image: notificationImage, style: .plain, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = notificationButton
    }
    
    private func updateTableViewContentSize(tableView: UITableView, size: CGFloat) {
        if tableView == recentlyActivityTableView {
            recentlyActivityTableViewHeightConstraint.constant = size
        } else if tableView == noteTableView {
            noteTableViewHeightConstraint.constant = size
        }
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
        if self.viewModel.isOpen {
            self.mainFloatingButton.setImage(UIImage(named: "icon_close"), for: .normal)
            self.clueCloseContainerView.isHidden = false
            self.newActivityButton.isHidden = false
            self.clueNewActivityContainerView.isHidden = false
            self.notesButton.isHidden = false
            self.clueNotesContainerView.isHidden = false
        } else {
            self.mainFloatingButton.setImage(UIImage(named: "icon_add"), for: .normal)
            self.clueCloseContainerView.isHidden = true
            self.newActivityButton.isHidden = true
            self.clueNewActivityContainerView.isHidden = true
            self.notesButton.isHidden = true
            self.clueNotesContainerView.isHidden = true
        }
    }
    
    @objc
    private func newActivityButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        let newActivityViewController = NewActivityViewController()
        navigationController?.pushViewController(newActivityViewController, animated: true)
    }
    
    @objc
    private func notesButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        let noteViewController = NoteViewController()
        navigationController?.pushViewController(noteViewController, animated: true)
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
        let notificationViewController = NotificationViewController()
        navigationController?.pushViewController(notificationViewController, animated: true)
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
    private func seeAllRecentlyActivityButtonTapped() {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
        let recentlyActivityViewController = RecentlyActivityViewController()
        let viewModel = RecentlyActivityViewModel(recentlyActivityUseCase: Injection().provideRecentlyActivityUseCase(), userId: viewModel.userId)
        recentlyActivityViewController.viewModel = viewModel
        navigationController?.pushViewController(recentlyActivityViewController, animated: true)
    }
    
    @objc
    private func seeAllNoteButtonTapped() {
        showSuccessSnackBar(message: "See all note Button Clicked!")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalletCollectionViewCell", for: indexPath) as? WalletCollectionViewCell else { return UICollectionViewCell() }
        let depo = viewModel.balanceValue
        let spending = viewModel.expenseValue
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
        switch tableView {
        case recentlyActivityTableView:
            return min(viewModel.recentlyActivityValue?.count ?? 0, 5)
        case noteTableView:
            return min(viewModel.catatanValue?.catatanId?.count ?? 0, 5)
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case recentlyActivityTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlyActivityTableViewCell", for: indexPath) as? RecentlyActivityTableViewCell else { return UITableViewCell() }
            let activity = viewModel.recentlyActivityValue?[indexPath.row]
            cell.configureContent(name: activity?.name, date: activity?.date, category: activity?.category, total: activity?.amount, type: activity?.type ?? .expense)
            cell.containerViewTopConstraint.constant = indexPath.row == 0 ? 0 : 12
            cell.containerViewBottomConstraint.constant = indexPath.row == (viewModel.expenseValue?.userId?.count ?? 0) - 1 ? 0 : 12
            return cell
        case noteTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
            let note = viewModel.catatanValue
            cell.configureContent(body: note?.body?[indexPath.row], title: note?.title?[indexPath.row], category: note?.title?[indexPath.row], createdAt: note?.createdAt?[indexPath.row])
            cell.containerViewTopConstraint.constant = indexPath.row == 0 ? 0 : 12
            cell.containerViewBottomConstraint.constant = indexPath.row == (viewModel.catatanValue?.catatanId?.count ?? 0) - 1 ? 0 : 12
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case recentlyActivityTableView:
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
            seeAllButton.addTarget(self, action: #selector(seeAllRecentlyActivityButtonTapped), for: .touchUpInside)
            seeAllButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            headerView.addSubview(seeAllButton)
            
            NSLayoutConstraint.activate([
                seeAllButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                seeAllButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            
            return headerView
        case noteTableView:
            let headerView = UIView()
            headerView.backgroundColor = .clear
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Note"
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
            seeAllButton.addTarget(self, action: #selector(seeAllNoteButtonTapped), for: .touchUpInside)
            seeAllButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            headerView.addSubview(seeAllButton)
            
            NSLayoutConstraint.activate([
                seeAllButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                seeAllButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            
            return headerView
        default:
            break
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case recentlyActivityTableView:
            return 50
        case noteTableView:
            return 50
        default:
            return 0
        }
    }
}

// MARK: - UIScrollViewDelegate
extension DashboardViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.isOpen {
            mainFloatingButtonTapped()
        }
    }
}
