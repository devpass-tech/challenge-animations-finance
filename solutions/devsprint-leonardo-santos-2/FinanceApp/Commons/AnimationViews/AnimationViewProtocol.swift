//
//  AnimationProtocol.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 28/07/22.
//

protocol AnimationViewRunnerProtocol {
    func run()
}

protocol AnimationViewReverserProtocol {
    func reverse()
}

protocol AnimationViewProtocol: AnimationViewRunnerProtocol, AnimationViewReverserProtocol {
    func animate()
}
