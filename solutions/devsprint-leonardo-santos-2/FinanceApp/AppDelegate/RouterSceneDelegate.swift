//
//  RouterSceneDelegate.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

final class RouterSceneDelegate: NSObject {
    
    var window: UIWindow?
    
    private func makeSplashScreen() -> SplashScreenViewController {
        let controller = SplashScreenViewController()
        controller.delegate = self
        return controller
    }
    
    private func configureWindow(with windowScene: UIWindowScene) {
        let controller = makeSplashScreen()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

//MARK: - UIWindowSceneDelegate
extension RouterSceneDelegate: UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureWindow(with: windowScene)
    }
}

//MARK: - SplashScreenViewControllerDelegate
extension RouterSceneDelegate: SplashScreenViewControllerDelegate {
    
    func splashScreenAnimationCompletes(_ controller: SplashScreenViewController) {
        let viewController = TabBarController()
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
    }
}
