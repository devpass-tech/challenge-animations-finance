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

final class SingleLoopAnimationView: UIView, AnimationViewProtocol {
    
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
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        lottieFile = .like
        super.init(frame: .zero)
        animationContainerView.frame = .zero
        commonInit()
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
    private func commonInit() {
        configureViewCode()
        configureAction()
    }
    
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
    
    private func configureAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loopViewHandleTapped))
        animationContainerView.addGestureRecognizer(tapGesture)
        animationContainerView.isUserInteractionEnabled = true
    }
    
    //MARK: - Selectors
    @objc private func loopViewHandleTapped() {
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
