//
//  SFSymbols.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 25/07/22.
//

import UIKit

protocol ImageAsset {
    var image: UIImage? { get }
}

enum SFSymbols: String, ImageAsset {
    case link
    case heart
    case heartFilled = "heart.fill"
    case xMark = "xmark"
    case check = "checkmark"
    
    var image: UIImage? {
        UIImage(systemName: rawValue)
    }
}

enum AssetsCatalog: String, ImageAsset {
    case circleBagFilled = "bag.circle.fill"
    
    var image: UIImage? {
        UIImage(systemName: rawValue)
    }
}
