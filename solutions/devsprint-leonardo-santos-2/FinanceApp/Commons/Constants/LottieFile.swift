//
//  LottieFile.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 28/07/22.
//

enum LottieFile: String {
    case splashScreen = "devpass_splashscreen"
    case circleLoading = "devpass_button_loading"
    case pullToRefresh = "devpass_pull_to_refresh_loading"
    
    var file: String { rawValue }
}
