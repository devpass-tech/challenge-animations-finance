//
//  EncoderProvider.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

protocol EncoderProvider {
    func encodeObject<T: Encodable>(_ value: T) -> Data?
}

extension JSONEncoder: EncoderProvider {
    func encodeObject<T: Encodable>(_ value: T) -> Data? { try? encode(value) }
}
