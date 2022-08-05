//
//  TabBarController.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/01/22.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .systemBlue
        delegate = self
        
        setupViewControllers()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let toIndex = viewControllers?.firstIndex(of: toVC),
              let fromIndex = viewControllers?.firstIndex(of: fromVC) else { return nil }
        
        let orientation: AnimationOrientation = toIndex > fromIndex ? .forward : .backward
        
        return TabbarAnimationObject(orientation: orientation)
    }
    
    private func setupViewControllers() {
        viewControllers = [
            createNavController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house.fill")),
            createNavController(for: TransfersViewController(), title: "Transfers", image: UIImage(systemName: "arrow.up.arrow.down"))]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
