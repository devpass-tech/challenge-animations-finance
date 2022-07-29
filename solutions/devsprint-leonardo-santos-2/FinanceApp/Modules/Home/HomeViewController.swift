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
        let remote = RemoteSplashScreenService()
        remote.fetchAnimation()
    }
}

//MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {

    func didSelectActivity() {
        let activityDetailsViewController = ActivityDetailsViewController()
        self.navigationController?.pushViewController(activityDetailsViewController, animated: true)
    }
}

import Lottie
struct RemoteSplashResponse {
    struct Response: Codable {
        let animation: Animation
        let fromDate: String
        let toDate: String
        
        enum CodingKeys: String, CodingKey {
            case animation = "animation"
            case fromDate = "from"
            case toDate = "to"
        }
    }
}


protocol RemoteSplashScreenServiceProtocol {
    
}

final class RemoteSplashScreenService: RemoteSplashScreenServiceProtocol {
    
    typealias Response = RemoteSplashResponse.Response
    typealias RSCompletionBlock = ((Response) -> Void)
    
    func fetchAnimation() {
        guard let path = Bundle.main.url(
            forResource: "splash-screen-remote-response",
            withExtension: "json"
        ) else {
            return
        }
        
        guard let data = try? Data(contentsOf: path) else { return }
        
        let decoder = JSONDecoder()
        let json = try? decoder.decode(Response.self, from: data)
        print(json)
    }
}
