//
//  SingleLopAnimationView.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 28/07/22.
//

import UIKit
import Lottie
import Cartography

protocol SingleLopAnimationViewDelegate: AnyObject {
    func animationViewHandleTapped(_ animationView: SingleLopAnimationView, with animation: AnimationView)
}

final class SingleLopAnimationView: UIView, AnimationViewProtocol {
    
    //MARK: - Properties
    private let lottieFile: LottieFile
    private(set) var animationFinished = false
    weak var delegate: SingleLopAnimationViewDelegate?
    
    //MARK: - UI Components
    private lazy var interactionView: UIControl = {
        let control = UIControl()
        control.isUserInteractionEnabled = true
        control.addTarget(self, action: #selector(loopViewHandleTapped), for: .touchUpInside)
        return control
    }()
    
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
        guard animationFinished else {
            return run()
        }
        
        return reverse()
    }
    
    //MARK: - Helpers
    private func commonInit() {
        configureViewCode()
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
    
    //MARK: - Selectors
    @objc private func loopViewHandleTapped() {
        delegate?.animationViewHandleTapped(self, with: animationContainerView)
    }
}

//MARK: - ViewCodeProtocol
extension SingleLopAnimationView: ViewCodeProtocol {
    func configureHierarcy() {
        addSubview(animationContainerView)
        animationContainerView.addSubview(interactionView)
    }
    
    func configureConstraint() {
        constrain(self, animationContainerView) {
            $0.edges == $1.edges
        }
        
        constrain(animationContainerView, interactionView) {
            $1.edges == $0.edges
        }
    }
}
