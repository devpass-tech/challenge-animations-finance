//
//  FadeAnimatorProtocol.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

protocol FadeAnimatorDelegate: AnyObject {
    func fadeAnimationCompleted(_ view: UIView, on stage: AnimationStage, animator: FadeAnimatorProtocol)
}

protocol FadeAnimatorProtocol: AnimatorProtocol {
    var delegate: FadeAnimatorDelegate? { get set }
}
