//
//  PositionAnimator.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

struct PositionAnimator: PositionAnimatorProtocol {
    var option: AnimationStage = .in
    var position: VerticalPosition = .top
    var delay: TimeInterval = .zero
    var duration: TimeInterval = 0.5
    
    weak var delegate: PositionAnimatorDelegate?
    
    func animate(_ view: UIView) {
        UIView.animate(
            withDuration: duration, delay: delay, options: [.curveEaseInOut],
            animations: { animationHandler(on: view) },
            completion: { completionHandler(on: view, completed: $0) }
        )
    }
    
    private func animationHandler(on view: UIView) {
        switch (position, option) {
        case (.top, .in):
            view.frame.origin.y += view.frame.height
        case (.top, .out):
            view.frame.origin.y -= view.frame.height
        case (.bottom, .in):
            view.frame.origin.y -= view.frame.height
        case (.bottom, .out):
            view.frame.origin.y += view.frame.height
        }
    }
    
    private func completionHandler(on view: UIView, completed: Bool) {
        guard completed else { return }
        delegate?.positionAnimationCompleted(view, at: position, animator: self)
    }
}
