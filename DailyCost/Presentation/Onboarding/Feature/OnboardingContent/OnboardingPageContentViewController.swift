//
//  OnboardingPageContentViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

class OnboardingPageContentViewController: UIViewController {
    @IBOutlet weak var onboardingProgressView: UIProgressView!
    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var pageIndex: Int!
    var page: OnboardingPage!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        initListener()
    }
    
    private func configureViews() {
        onboardingProgressView.layer.cornerRadius = 5
        onboardingProgressView.layer.masksToBounds = true
        onboardingProgressView.progress = page.progress
        onboardingImageView.image = UIImage(named: page.imageName)
        titleLabel.text = page.title
        subtitleLabel.text = page.subtitle
        nextButton.setTitle(page.nextButtonText, for: .normal)
        nextButton.layer.cornerRadius = 12
        nextButton.layer.masksToBounds = true
        skipButton.setTitle(page.skipButtonText, for: .normal)
        if page.skipButtonText == "Sign Up" {
            skipButton.layer.borderWidth = 2
            skipButton.layer.borderColor = UIColor.primary100.cgColor
            skipButton.layer.cornerRadius = 5
            skipButton.setTitleColor(.primary100, for: .normal)
            skipButton.backgroundColor = .clear
            skipButton.layer.cornerRadius = 12
            skipButton.layer.masksToBounds = true
        } else {
            skipButton.layer.borderWidth = 0
            skipButton.layer.borderColor = nil
            skipButton.layer.cornerRadius = 0
            skipButton.setTitleColor(.primary100, for: .normal)
            skipButton.backgroundColor = .clear
            skipButton.layer.cornerRadius = 12
            skipButton.layer.masksToBounds = true
        }
    }
    
    private func initListener() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    func nextButtonTapped() {
        if let parent = self.parent as? OnboardingViewController {
            parent.currentIndex += 1
            if parent.currentIndex < parent.pages.count {
                parent.setViewControllers([parent.viewControllerAtIndex(index: parent.currentIndex)!], direction: .forward, animated: false, completion: nil)
            } else {
                let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
                parent.navigationController?.pushViewController(signInVC, animated: true)
            }
        }
    }
    
    @objc
    func skipButtonTapped() {
        if let parent = self.parent as? OnboardingViewController {
            if parent.currentIndex == parent.pages.count - 1 {
                let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
                parent.navigationController?.pushViewController(signUpVC, animated: true)
            } else {
                parent.currentIndex = parent.pages.count - 1
                parent.setViewControllers([parent.viewControllerAtIndex(index: parent.currentIndex)!], direction: .forward, animated: false, completion: nil)
            }
        }
    }
}
