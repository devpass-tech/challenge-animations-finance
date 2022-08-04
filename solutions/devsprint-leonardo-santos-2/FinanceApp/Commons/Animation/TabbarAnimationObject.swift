//
//  TabbarAnimationObject.swift
//  FinanceApp
//
//  Created by Pedro Léda on 03/08/22.
//

import UIKit

final class TabbarAnimationObject: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let orientation: AnimationOrientation
    
    init(orientation: AnimationOrientation) {
        self.orientation = orientation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVc = transitionContext.viewController(forKey: .from),
              let toVc = transitionContext.viewController(forKey: .to) else { return }
        
        let finalFrame = transitionContext.finalFrame(for: toVc)
        let container = transitionContext.containerView
        
        let duration = transitionDuration(using: transitionContext)
        
        switch orientation {
        case .forward:
            forwardAnimation(fromVc: fromVc,
                             toVc: toVc,
                             container: container,
                             duration: duration,
                             finalFrame: finalFrame) { isCompleted in
                transitionContext.completeTransition(isCompleted && !transitionContext.transitionWasCancelled)
            }
        case .backward:
            backwardAnimation(fromVc: fromVc,
                             toVc: toVc,
                             container: container,
                             duration: duration,
                             finalFrame: finalFrame) { isCompleted in
                transitionContext.completeTransition(isCompleted && !transitionContext.transitionWasCancelled)
            }
        }
    }
    
    private func forwardAnimation(fromVc: UIViewController, toVc: UIViewController, container: UIView, duration: TimeInterval, finalFrame: CGRect, completion: @escaping (Bool) -> Void) {
        
        toVc.view.frame = finalFrame.offsetBy(dx: UIScreen.main.bounds.width, dy: 0)
        toVc.view.alpha = 0
        
        container.addSubview(toVc.view)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            
            fromVc.view.frame = fromVc.view.frame.offsetBy(dx: -UIScreen.main.bounds.width, dy: 0)
            fromVc.view.alpha = 0
            fromVc.view.transform = fromVc.view.transform.scaledBy(x: 0.8, y: 0.8)
            
            toVc.view.frame = finalFrame
            toVc.view.alpha = 1
            
        } completion: { isCompleted in
            fromVc.view.transform = .identity
            completion(isCompleted)
        }
    }
    
    private func backwardAnimation(fromVc: UIViewController, toVc: UIViewController, container: UIView, duration: TimeInterval, finalFrame: CGRect, completion: @escaping (Bool) -> Void) {
        
        toVc.view.frame = finalFrame.offsetBy(dx: -UIScreen.main.bounds.width, dy: 0)
        toVc.view.alpha = 0
        
        container.addSubview(toVc.view)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            
            fromVc.view.frame = fromVc.view.frame.offsetBy(dx: UIScreen.main.bounds.width, dy: 0)
            fromVc.view.alpha = 0
            fromVc.view.transform = fromVc.view.transform.scaledBy(x: 0.8, y: 0.8)
            
            toVc.view.frame = finalFrame
            toVc.view.alpha = 1
            
        } completion: { isCompleted in
            fromVc.view.transform = .identity
            completion(isCompleted)
        }
    }
}
