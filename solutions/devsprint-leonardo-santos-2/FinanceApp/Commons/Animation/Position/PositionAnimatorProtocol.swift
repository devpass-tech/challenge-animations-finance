//
//  PositionAnimatorProtocol.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

protocol PositionAnimatorDelegate: AnyObject {
    func positionAnimationCompleted(_ view: UIView, at position: VerticalPosition, animator: PositionAnimatorProtocol)
}

protocol PositionAnimatorProtocol: AnimatorProtocol {
    var position: VerticalPosition { get set }
    var delegate: PositionAnimatorDelegate? { get set }
}
