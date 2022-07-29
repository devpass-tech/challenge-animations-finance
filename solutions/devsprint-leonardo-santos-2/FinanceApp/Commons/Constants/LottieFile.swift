//
//  LottieFile.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 27/07/22.
//

import Foundation

enum LottieFile: String {
    case splashScreen = "devpass_splashscreen"
    case circleLoading = "devpass_button_loading"
    case like = "devpass_button_like"
    
    var file: String { rawValue }
}
