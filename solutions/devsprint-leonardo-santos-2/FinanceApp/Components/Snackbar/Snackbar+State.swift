//
//  Snackbar+State.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

extension Snackbar {
    enum State {
        case success(String)
        case failure(String)
        case none
        
        var icon: UIImage? {
            let image: UIImage?
            switch self {
            case .success:
                image =  SFSymbols.check.image
            case .failure:
                image =  SFSymbols.xMark.image
            case .none:
                image = nil
            }
            
            return image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
        
        var description: String {
            switch self {
            case .success(let description):
                return description
            case .failure(let description):
                return description
            case .none:
                return "Description"
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .success:
                return .successGreen
            case .failure:
                return .failureRed
            case .none:
                return .darkGray
            }
        }
    }
}
