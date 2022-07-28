//
//  FadeAnimator.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

struct FadeAnimator: FadeAnimatorProtocol {
    
    private enum Step {
        case initial
        case animating
    }
    
    //MARK: - Properties
    var option: AnimationStage
    var minOpacity: CGFloat
    var maxOpacity: CGFloat
    var delay: TimeInterval
    var duration: TimeInterval
    
    weak var delegate: FadeAnimatorDelegate?
    
    //MARK: - Initializers
    init(
        option: AnimationStage = .in,
        minOpacity: CGFloat = .zero,
        maxOpacity: CGFloat = 1,
        duration: TimeInterval = 0.5,
        delay: TimeInterval = .zero
    ) {
        self.option = option
        self.minOpacity = minOpacity
        self.maxOpacity = maxOpacity
        self.duration = duration
        self.delay = delay
    }
    
    //MARK: - Helpers
    
    private func animationCompletion(_ view: UIView, completed: Bool) {
        guard completed else { return }
        self.delegate?.fadeAnimationCompleted(view, on: option, animator: self)
    }
    
    private func opacityHandler(for view: UIView, on step: Step) {
        switch (option, step) {
        case (.in, .initial):
            view.alpha = minOpacity
        case (.in, .animating):
            view.alpha = maxOpacity
        case (.out, .initial):
            view.alpha = maxOpacity
        case (.out, .animating):
            view.alpha = minOpacity
        }
    }
    
    func animate(_ view: UIView) {
        opacityHandler(for: view, on: .initial)
        
        UIView.animate(
            withDuration: duration, delay: delay, options: [],
            animations: { opacityHandler(for: view, on: .animating) },
            completion: { animationCompletion(view, completed: $0) }
        )
    }
}
