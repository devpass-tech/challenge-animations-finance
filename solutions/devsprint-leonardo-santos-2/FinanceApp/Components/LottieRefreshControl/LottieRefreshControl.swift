//
//  LottieRefreshControl.swift
//  FinanceApp
//
//  Created by Alexandre Cardoso on 02/08/22.
//

import Cartography
import Lottie
import UIKit

final class LottieRefreshControl: UIRefreshControl {
    
    private let lottieName: String
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: lottieName)
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.8
        animationView.backgroundColor = .white
        animationView.play()
        return animationView
    }()
    
    init(lottieName: String) {
        self.lottieName = lottieName
        super.init()
        backgroundColor = .white
        addAnimationLottie()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func addAnimationLottie() {
        self.addSubview(animationView)
    }
    
    private func setupConstraints() {
        constrain(self, animationView) {
            $1.top == $0.top
            $1.leading == $0.leading
            $1.trailing == $0.trailing
            $1.bottom == $0.bottom
        }
    }

}
