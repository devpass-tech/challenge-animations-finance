//
//  SingleLoopAnimationView.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 28/07/22.
//

import UIKit
import Lottie
import Cartography

protocol SingleLoopAnimationViewDelegate: AnyObject {
    func animationViewHandleTapped(_ animationView: SingleLoopAnimationView, with animation: AnimationView)
}

final class SingleLoopAnimationView: UIButton, AnimationViewProtocol {
    
    //MARK: - Properties
    private let lottieFile: LottieFile
    private var animationFinished = false
    weak var delegate: SingleLoopAnimationViewDelegate?
    
    //MARK: - UI Components
    private lazy var animationContainerView: AnimationView = {
        let av = AnimationView(name: lottieFile.file)
        return av
    }()
    
    //MARK: - Initializers
    init(lottie: LottieFile, frame size: CGRect = .zero) {
        lottieFile = lottie
        super.init(frame: .zero)
        animationContainerView.frame = size
        configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        lottieFile = .like
        super.init(frame: .zero)
        animationContainerView.frame = .zero
        configureViewCode()
    }
    
    //MARK: - Methods
    func run() {
        animationFinished = true
        perform(from: .zero, to: 1)
    }
    
    func reverse() {
        animationFinished = false
        perform(from: 1, to: .zero)
    }
    
    func animate() {
        animationFinished ? reverse() : run()
    }
    
    //MARK: - Helpers
    
    private func perform(
        from initialFrame: AnimationFrameTime,
        to endedFrame: AnimationFrameTime
    ) {
        animationContainerView.play(
            fromProgress: initialFrame,
            toProgress: endedFrame,
            loopMode: .playOnce
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.animationViewHandleTapped(self, with: animationContainerView)
    }
}

//MARK: - ViewCodeProtocol
extension SingleLoopAnimationView: ViewCodeProtocol {
    func configureHierarcy() {
        addSubview(animationContainerView)
    }
    
    func configureConstraint() {
        constrain(self, animationContainerView) {
            $0.edges == $1.edges
        }
    }
    
    func configureStyle() {
        resignFirstResponder()
    }
}
