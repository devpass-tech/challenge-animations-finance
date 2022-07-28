//
//  UIColor+Extensions.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

extension UIColor {
    
    static var devpass: UIColorHelper { .shared }
    
    struct UIColorHelper {
        static let shared: Self = .init()
        
        let successGreen = #colorLiteral(red: 0.1516196132, green: 0.688331604, blue: 0.3336164355, alpha: 1)
        let failureRed: UIColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }
}
