//
//  OnboardingViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    var pages: [OnboardingPage] = [
        OnboardingPage(progress: 0.25, imageName: "icon_wallet_with_cash", title: "You can see where the money goes", subtitle: "It’s easy to spot the categories that draw more resources than you’d think", nextButtonText: "Next", skipButtonText: "Skip"),
        OnboardingPage(progress: 0.50, imageName: "icon_coins", title: "Achieving your goals is easier", subtitle: "Spending plan show how much money is free to be used for the new goals", nextButtonText: "Next", skipButtonText: "Skip"),
        OnboardingPage(progress: 0.75, imageName: "icon_credit_card", title: "All card and accounts in one app", subtitle: "Secure synchronization with banks", nextButtonText: "Next", skipButtonText: "Skip"),
        OnboardingPage(progress: 1.00, imageName: "icon_calculator", title: "No need to add expenses manually", subtitle: "Your bank transactions are deliverd automatically", nextButtonText: "Sign In", skipButtonText: "Sign Up")
    ]
    
    var currentIndex: Int = 0
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let firstPage = viewControllerAtIndex(index: 0) {
            setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
        }
        for gesture in self.gestureRecognizers {
            gesture.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentVC = viewControllers?.first as? OnboardingPageContentViewController {
            currentIndex = currentVC.pageIndex
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Helpers
    func viewControllerAtIndex(index: Int) -> OnboardingPageContentViewController? {
        if index >= pages.count { return nil }
        
        let contentVC = OnboardingPageContentViewController(nibName: "OnboardingPageContentViewController", bundle: nil)
        contentVC.page = pages[index]
        contentVC.pageIndex = index
        return contentVC
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? OnboardingPageContentViewController, vc.pageIndex > 0 {
            return viewControllerAtIndex(index: vc.pageIndex - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? OnboardingPageContentViewController, vc.pageIndex < pages.count - 1 {
            return viewControllerAtIndex(index: vc.pageIndex + 1)
        }
        return nil
    }
}
