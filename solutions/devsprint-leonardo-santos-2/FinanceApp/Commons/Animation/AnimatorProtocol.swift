//
//  AnimatorProtocol.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

protocol AnimatorProtocol {
    var delay: TimeInterval { get }
    var duration: TimeInterval { get }
    var option: AnimationStage { get set }
    func animate(_ view: UIView)
}
