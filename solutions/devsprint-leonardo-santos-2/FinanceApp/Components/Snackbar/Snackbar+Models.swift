//
//  Snackbar+Models.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 25/07/22.
//

import Foundation

extension Snackbar {
    
    struct ViewData {
        var state: State = .success
        var symbol: SFSymbols = .xMark
        var description: String = "Description"
    }
    
    enum Position {
        case top
        case bottom
    }
    
    enum State {
        case success
        case failure
    }
}
