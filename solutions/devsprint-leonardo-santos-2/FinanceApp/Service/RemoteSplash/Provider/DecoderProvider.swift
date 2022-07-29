//
//  DecoderProvider.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

protocol DecoderProvider {
    func performDecode<O: Decodable>(_ type: O.Type, from data: Data?) -> O?
}

extension JSONDecoder: DecoderProvider {
    func performDecode<O>(_ type: O.Type, from data: Data?) -> O? where O : Decodable {
        guard let data = data else { return nil }
        return try? decode(O.self, from: data)
    }
}
