//
//  SnackDragGestureHandler.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

struct SnackDragGestureHandler: DragGestureProtocol {
    
    weak var delegate: DragGestureDelegate?
    
    var startPosition: CGFloat
    var position: VerticalPosition

    init(reference: UIView, at position: VerticalPosition) {
        self.position = position
        switch self.position {
        case .top:
            startPosition = reference.frame.minY + reference.frame.height + 50
        case .bottom:
            let pOnSuperView = reference.superview!.frame.maxY - (-reference.frame.minY)
            startPosition = pOnSuperView - 50
        }
    }

    func handle(_ view: UIView, for gesture: UIPanGestureRecognizer) {
        guard let superView = view.superview else { return }
        let dragPosition = gesture.translation(in: superView)

        let currentPosition: CGFloat = dragPosition.y + startPosition

        switch gesture.state {
        case .changed:
            switch position {
            case .top:
                guard currentPosition < startPosition else { return }
                view.frame.origin.y = currentPosition
            case .bottom:
                guard currentPosition > startPosition else { return }
                view.frame.origin.y = currentPosition
            }

        case.ended:
            switch position {
            case .top:
                guard currentPosition > startPosition - view.frame.height else {
                    delegate?.dragGestureDismissed(view, at: position, dragGesture: self)
                    return
                }
                view.frame.origin.y = startPosition
            case .bottom:
                guard currentPosition < startPosition + view.frame.height else {
                    delegate?.dragGestureDismissed(view, at: position, dragGesture: self)
                    return
                }
                view.frame.origin.y = startPosition
            }

        default:
            break
        }
    }
}
