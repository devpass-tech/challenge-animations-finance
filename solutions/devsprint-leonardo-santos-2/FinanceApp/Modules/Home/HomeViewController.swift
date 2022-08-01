//
//  HomeViewController.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - UI Components
    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.delegate = self
        return homeView
    }()
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
    }
    
    //MARK: - Helpers
    private func onViewDidLoad() {
        showSkeletonView()
        configureRightButton()
        showSpashScreen()
    }
    
    private func configureRightButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Profile", style: .plain,
            target: self, action: #selector(openProfile)
        )
    }
    
    private func showSpashScreen() {
        let controller = SplashScreenViewController()
        controller.delegate = self
        controller.modalPresentationStyle = .custom
        present(controller, animated: false, completion: nil)
    }
    
    private func showSkeletonView() {
        homeView.homeHeaderView.skeletonHomeHeader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.homeView.homeHeaderView.hideSkeleton()
        })
    }
    
    //MARK: - Selctors
    @objc private func openProfile() {
        let controller = UserProfileViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true)
    }
}

//MARK: - SplashScreenViewControllerDelegate
extension HomeViewController: SplashScreenViewControllerDelegate {
    
    func splashScreenAnimationCompletes(_ controller: SplashScreenViewController) {
        controller.dismiss(animated: false)
    }
}

//MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    
    func didSelectActivity() {
        let activityDetailsViewController = ActivityDetailsViewController()
        self.navigationController?.pushViewController(activityDetailsViewController, animated: true)
    }
}
