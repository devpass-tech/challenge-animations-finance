//
//  HomeViewController.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit

//RemoteSplashResponse.Response
final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private let localManager: UserDefaultManagerProtocol
    private let remoteManager: FinanceServiceProtocol
    
    //MARK: - UI Components
    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.delegate = self
        return homeView
    }()

    
    //MARK: - Initializers
    init(
        localManager: UserDefaultManagerProtocol = UserDefaultManager(),
        remoteManager: FinanceServiceProtocol = FinanceService()
    ) {
        self.localManager = localManager
        self.remoteManager = remoteManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.localManager = UserDefaultManager()
        self.remoteManager = FinanceService()
        super.init()
    }
    
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
        remoteManager.fetchSplash(for: .remoteSplash) { result in
            switch result {
            case .success(let reponse): localManager.setObject(reponse, for: .splashScreen)
            case .failure: break
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







protocol UserDefaultManagerProtocol {
    func setObject<Value: Encodable>(_ object: Value, for key: UserDefaultKeys)
    func getObject<Value: Decodable>(for key: UserDefaultKeys, expect: Value.Type) -> Value?
}

struct UserDefaultManager: UserDefaultManagerProtocol {
    
    //MARK: - Properties
    private let dataBase: UserDefaultProvider
    private let encoder: EncoderProvider
    private let decoder: DecoderProvider
    
    //MARK: - Initializers
    init(
        dataBaseProvider: UserDefaultProvider = UserDefaults.standard,
        encoderProvider: EncoderProvider = JSONEncoder(),
        decoderProvider: DecoderProvider = JSONDecoder()
    ) {
        dataBase = dataBaseProvider
        encoder = encoderProvider
        decoder = decoderProvider
    }
    
    //MARK: - UserDefaultManagerProtocol
    func setObject<Value: Encodable>(_ object: Value, for key: UserDefaultKeys) {
        guard let data = encoder.encodeObject(object) else { return }
        dataBase.setObject(data, forKey: key.rawValue)
    }
    
    func getObject<Value: Decodable>(for key: UserDefaultKeys, expect: Value.Type) -> Value? {
        guard let data = dataBase.asData(forKey: key.rawValue) else { return nil }
        return decoder.decodeObject(expect.self, from: data)
    }
}
