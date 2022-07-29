//
//  UserDefaultProvider.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

protocol UserDefaultProvider {
    func asData(forKey defaultName: String) -> Data?
    func setObject(_ value: Data, forKey defaultName: String)
}

extension UserDefaults: UserDefaultProvider {
    func asData(forKey defaultName: String) -> Data? {
        data(forKey: defaultName)
    }
    
    func setObject(_ value: Data, forKey defaultName: String) {
        set(value, forKey: defaultName)
    }
}
