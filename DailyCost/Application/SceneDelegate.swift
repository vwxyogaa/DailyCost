//
//  SceneDelegate.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        if LoginKey.stateLogin {
            let viewController = DashboardViewController()
            let dashboardViewModel = DashboardViewModel(dashboardUseCase: Injection().provideDashboardUseCase(), userId: Int(LoginKey.userId) ?? 0)
            viewController.viewModel = dashboardViewModel
            let navigationController = UINavigationController(rootViewController: viewController)
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            let window = UIWindow(windowScene: windowScene)
            let viewController = OnboardingViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
