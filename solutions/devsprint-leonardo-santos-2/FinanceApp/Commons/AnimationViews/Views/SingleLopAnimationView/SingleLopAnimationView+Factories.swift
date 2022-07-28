//
//  SingleLopAnimationView+Factories.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 28/07/22.
//

import UIKit

extension SingleLopAnimationView {
    
    static func `default`(file: LottieFile, size: CGFloat) -> SingleLopAnimationView {
        SingleLopAnimationView(
            lottie: file,
            frame: .init(x: .zero, y: .zero, width: size, height: size)
        )
    }
}
