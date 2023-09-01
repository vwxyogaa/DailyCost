//
//  DashboardViewController.swift
//  DailyCost
//
//  Created by yxgg on 30/08/23.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var containerCardWallet: UIView!
    @IBOutlet weak var cardWalletView: UIView!
    @IBOutlet weak var titleWalletLabel: UILabel!
    @IBOutlet weak var balanceWalletLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var expenseWalletLabel: UILabel!
    @IBOutlet weak var addWalletButton: UIButton!
    @IBOutlet weak var topupButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    private var cards: [UIView] = []
    private var cardDatas: [CardData] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonNavBar()
        loadDataFromAPI()
        configureViews()
        setupCards()
    }
    
    // MARK: - Helpers
    private func loadDataFromAPI() {
        cardDatas = [
            CardData(title: "Subscribtion’s wallet", balance: "300.000", monthlyExpense: "100.000"),
            CardData(title: "E-Wallet", balance: "500.000", monthlyExpense: "250.000"),
            CardData(title: "Bank Account", balance: "900.000", monthlyExpense: "500.000")
        ]
    }
    
    private func configureViews() {
        containerCardWallet.layer.cornerRadius = 18
        containerCardWallet.layer.masksToBounds = true
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    private func setupCards() {
        for data in cardDatas {
            let card = createCard(with: data)
            cards.append(card)
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
            card.addGestureRecognizer(panGesture)
        }
    }
    
    private func createCard(with data: CardData) -> UIView {
        switch data.title {
        case "Subscribtion’s wallet":
            cardWalletView.backgroundColor = .systemOrange
        case "E-Wallet":
            cardWalletView.backgroundColor = .systemPurple
        case "Bank Account":
            cardWalletView.backgroundColor = .systemGreen
        default:
            cardWalletView.backgroundColor = .systemGray
        }
        cardWalletView.layer.cornerRadius = 15
        cardWalletView.layer.shadowOpacity = 0.1
        cardWalletView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardWalletView.layer.shadowRadius = 5
        
        titleWalletLabel.text = data.title
        let secureText = String(repeating: "•", count: data.balance?.count ?? 0)
        balanceWalletLabel.text = "Rp \(secureText)"
        expenseWalletLabel.text = "Monthly expenses Rp \(data.monthlyExpense ?? "0")"
        
        return cardWalletView
    }
    
    private func configureButtonNavBar() {
        let leftImage = UIImage(named: "icon_dashboard")?.withRenderingMode(.alwaysOriginal)
        let leftButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.leftBarButtonItem = leftButton
        
        let rightImage = UIImage(named: "icon_notification")?.withRenderingMode(.alwaysOriginal)
        let rightButton = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func rearrangeCardOrder(for card: UIView) {
        guard let cardIndex = cards.firstIndex(of: card) else { return }
        
        cards.remove(at: cardIndex)
        cards.append(card)
        
        for cardView in cards {
            containerCardWallet.sendSubviewToBack(cardView)
        }
    }
    
    // MARK: - Actions
    @objc
    private func eyeButtonTapped() {
        eyeButton.isSelected = !eyeButton.isSelected
        if let data = cardDatas.first {
            if eyeButton.isSelected {
                balanceWalletLabel.text = "Rp \(data.balance ?? "0")"
            } else {
                let secureText = String(repeating: "•", count: data.balance?.count ?? 0)
                balanceWalletLabel.text = "Rp \(secureText)"
            }
        }
    }
    
    @objc
    private func leftButtonTapped() {
        showSuccessSnackBar(message: "Dashboard Button Clicked!")
    }
    
    @objc
    private func rightButtonTapped() {
        showSuccessSnackBar(message: "Notification Button Clicked!")
    }
    
    @objc
    private func handlePan(gesture: UIPanGestureRecognizer) {
        guard let card = gesture.view else { return }
        
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.view)
            card.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            if abs(gesture.velocity(in: self.view).y) > 500 {
                let destination: CGFloat = gesture.velocity(in: self.view).y > 0 ? self.view.bounds.height : -self.view.bounds.height
                UIView.animate(withDuration: 0.3, animations: {
                    card.transform = CGAffineTransform(translationX: 0, y: destination)
                }) { _ in
                    card.transform = .identity
                    self.rearrangeCardOrder(for: card)
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    card.transform = .identity
                }
            }
        default:
            break
        }
    }
}
