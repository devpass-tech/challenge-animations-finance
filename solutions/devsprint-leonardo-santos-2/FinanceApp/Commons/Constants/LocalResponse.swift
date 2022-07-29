//
//  DevpassLocalResponse.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

enum LocalResponse: String {
    case remoteSplash = "splash-screen-remote-response"
    
    var path: URL? {
        Bundle.main.url(forResource: rawValue, withExtension: "json")
    }
}
