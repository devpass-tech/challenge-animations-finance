//
//  SFSymbols.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 25/07/22.
//

import UIKit

enum SFSymbols: String {
    case xMark = "xmark"
    
    var image: UIImage? {
        UIImage(systemName: rawValue)
    }
}
