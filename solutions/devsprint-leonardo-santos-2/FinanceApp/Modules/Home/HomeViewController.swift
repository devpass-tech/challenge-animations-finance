//
//  HomeViewController.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let localManager: UserDefaultManager<RemoteSplashResponse.Response> = .init()

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
        updateAnimation()
    }
    
    private func updateAnimation() {
        let remote = RemoteSplashScreenService()
        remote.fetch(for: .remoteSplash) { result in
            switch result {
            case .success(let reponse):
                localManager.setObject(reponse, for: .splashScreen)
                print("✅ Response:", reponse)
            case .failure(let error):
                print("❌ Error:", error)
            }
        }
    }
}

//MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {

    func didSelectActivity() {
        let activityDetailsViewController = ActivityDetailsViewController()
        self.navigationController?.pushViewController(activityDetailsViewController, animated: true)
    }
}

struct UserDefaultManager<Value: Codable> {
    
    private let userDefault: UserDefaults = .standard
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()
    
    func setObject(_ object: Value, for key: UserDefaultKeys) {
        guard let data = try? encoder.encode(object) else { return }
        userDefault.set(data, forKey: key.rawValue)
    }
    
    func getObject(for key: UserDefaultKeys) -> Value? {
        guard let data = userDefault.data(forKey: key.rawValue) else { return nil }
        return try? decoder.decode(Value.self, from: data)
    }
}
