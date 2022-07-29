//
//  RemoteSplashResponse.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation
import Lottie

struct RemoteSplashResponse {
    struct Response: Codable {
        let animation: Animation
        let fromDate: String
        let toDate: String
        
        enum CodingKeys: String, CodingKey {
            case animation = "animation"
            case fromDate = "from"
            case toDate = "to"
        }
    }
}
