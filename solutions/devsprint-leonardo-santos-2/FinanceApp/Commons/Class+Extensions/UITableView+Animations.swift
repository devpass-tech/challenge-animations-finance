//
//  UITableView+Animations.swift
//  FinanceApp
//
//  Created by Pedro Léda on 03/08/22.
//

import UIKit

enum AnimationOrientation {
    case forward, backward
}

enum AnimationDirection {
    case horizontal(_ orientation: AnimationOrientation)
    case vertical(_ orientation: AnimationOrientation)
}

extension UITableView {
    
    func reloadWithAnimation(direction: AnimationDirection = .vertical(.forward)) {
        
        alpha = 0
        reloadData()
        
        let cells = visibleCells
        
        cells.forEach {
            $0.alpha = 0
            
            switch direction {
            case .horizontal(let orientation):
                $0.transform = $0.transform.translatedBy(x: orientation == .forward ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width, y: 0)
            case .vertical(let orientation):
                $0.transform = $0.transform.translatedBy(x: 0,
                                                         y: orientation == .forward ? UIScreen.main.bounds.height : -UIScreen.main.bounds.height)
            }
        }
        
        alpha = 1
        
        cells.enumerated().forEach { (index, cell) in
            UIView.animate(withDuration: 1,
                           delay: 0.05 * Double(index),
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1, options: .curveEaseInOut) {
                cell.alpha = 1
                cell.transform = .identity
            }
        }
    }
}

