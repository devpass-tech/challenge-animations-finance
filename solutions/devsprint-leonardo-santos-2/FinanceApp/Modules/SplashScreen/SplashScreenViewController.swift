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
    
    //MARK: - UI Componentes
    private lazy var logoViewAnimate: AnimationView = {
        let view = AnimationView(name: LottieFile.splashScreen.file)
        view.loopMode = .playOnce
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        view.backgroundColor = .white
    }
}

enum LottieFile: String {
    case splashScreen = "devpass_splashscreen"
    
    var file: String { rawValue }
}
