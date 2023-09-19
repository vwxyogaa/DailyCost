//
//  DrawerMenuViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 08/09/23.
//

import UIKit

class DrawerMenuViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var recentlyActivityView: UIView!
    @IBOutlet weak var statisticView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var advanceSettingView: UIView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var signOutView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    let transitionManager = DrawerTransitionManager()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = transitionManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        initListener()
    }
    
    private func configureViews() {
        emailLabel.text = LoginKey.userName
    }
    
    private func initListener() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let tapGestureHomeView = UITapGestureRecognizer(target: self, action: #selector(homeViewTapped))
        homeView.addGestureRecognizer(tapGestureHomeView)
        
        let tapGestureRecentlyActivityView = UITapGestureRecognizer(target: self, action: #selector(recentlyActivityViewTapped))
        recentlyActivityView.addGestureRecognizer(tapGestureRecentlyActivityView)
        
        let tapGestureStatisticView = UITapGestureRecognizer(target: self, action: #selector(statisticViewTapped))
        statisticView.addGestureRecognizer(tapGestureStatisticView)
        
        let tapGestureCategoryView = UITapGestureRecognizer(target: self, action: #selector(categoryViewTapped))
        categoryView.addGestureRecognizer(tapGestureCategoryView)
        
        let tapGestuRenoteView = UITapGestureRecognizer(target: self, action: #selector(noteViewTapped))
        noteView.addGestureRecognizer(tapGestuRenoteView)
        
        let tapGestureAdvanceSettingView = UITapGestureRecognizer(target: self, action: #selector(advanceSettingViewTapped))
        advanceSettingView.addGestureRecognizer(tapGestureAdvanceSettingView)
        
        let tapGestureLanguageView = UITapGestureRecognizer(target: self, action: #selector(languageViewTapped))
        languageView.addGestureRecognizer(tapGestureLanguageView)
        
        let tapGestureSignOutView = UITapGestureRecognizer(target: self, action: #selector(signOutViewTapped))
        signOutView.addGestureRecognizer(tapGestureSignOutView)
    }
    
    private func redirectToOnBoardingPage() {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }
        
        let rootController = OnboardingViewController()
        let snapshot = firstWindow.snapshotView(afterScreenUpdates: true)!
        rootController.view.addSubview(snapshot)
        
        firstWindow.rootViewController = rootController
        
        UIView.transition(with: snapshot,
                          duration: 0.3,
                          options: .curveEaseInOut,
                          animations: {
            snapshot.layer.opacity = 0
        },
                          completion: { status in
            snapshot.removeFromSuperview()
        })
        firstWindow.makeKeyAndVisible()
    }
    
    // MARK: - Actions
    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func homeViewTapped() {
        showSuccessSnackBar(message: "Home tapped")
    }
    
    @objc
    private func recentlyActivityViewTapped() {
        showSuccessSnackBar(message: "Recently activity tapped")
    }
    
    @objc
    private func statisticViewTapped() {
        showSuccessSnackBar(message: "Statistic tapped")
    }
    
    @objc
    private func categoryViewTapped() {
        showSuccessSnackBar(message: "Category tapped")
    }
    
    @objc
    private func noteViewTapped() {
        showSuccessSnackBar(message: "Note tapped")
    }
    
    @objc
    private func advanceSettingViewTapped() {
        showSuccessSnackBar(message: "Advance setting tapped")
    }
    
    @objc
    private func languageViewTapped() {
        showSuccessSnackBar(message: "Language tapped")
    }
    
    @objc
    private func signOutViewTapped() {
        let alert = UIAlertController(title: "", message: "Apakah anda ingin sign out?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Ya", style: .default) { _ in
            if LoginKey.deleteAllKey() {
                self.redirectToOnBoardingPage()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
