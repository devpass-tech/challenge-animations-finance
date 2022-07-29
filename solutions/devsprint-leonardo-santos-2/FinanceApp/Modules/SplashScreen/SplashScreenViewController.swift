//
//  SplashScreenViewController.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit
import Lottie

protocol SplashScreenViewControllerDelegate: AnyObject {
    func splashScreenAnimationCompletes(_ controller: SplashScreenViewController)
}

final class SplashScreenViewController: UIViewController {
    
    //MARK: - Properties
    weak var delegate: SplashScreenViewControllerDelegate?
    private let localManager: UserDefaultManagerProtocol
    
    //MARK: - UI Componentes
    private lazy var logoViewAnimate = makeAnimatedView()
    
    //MARK: - Initializers
    init(
        localManager: UserDefaultManagerProtocol = UserDefaultManager()
    ) {
        self.localManager = localManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.localManager = UserDefaultManager()
        super.init()
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = logoViewAnimate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performLaunchScreenAnimation()
    }
    
    //MARK: - Helpers
    private func performLaunchScreenAnimation() {
        logoViewAnimate.play { [weak self] completed in
            guard let self = self else { return }
            self.delegate?.splashScreenAnimationCompletes(self)
        }
    }
    
    private func configureStyle() {
        view.backgroundColor = .clear
    }
    
    private func makeAnimatedView() -> AnimationView {
        let viewAnimated = animationViewInitialization()
        viewAnimated.loopMode = .playOnce
        viewAnimated.contentMode = .scaleAspectFit
        
        return viewAnimated
    }
    
    private func animationViewInitialization() -> AnimationView {
        let reponse = localManager.getObject(
            for: .splashScreen,
            expect: RemoteSplashResponse.self
        )
        if let reponse = reponse, todayIsBetween(reponse) {
            return .init(animation: reponse.animation)
        }
        
        return .init(name: LottieFile.splashScreen.file)
    }
    
    private func todayIsBetween(_ reponse: RemoteSplashResponse) -> Bool {
        guard let startDate = reponse.fromDate.devpass.toDate(),
              let endDate = reponse.toDate.devpass.toDate() else { return false }
        
        let today = Date()
        return today.devpass.isBetween(start: startDate, end: endDate)
    }
}
