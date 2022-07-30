//
//  Date+Extensions.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

extension Date {
    
    func isBetween(start: Date, end: Date) -> Bool {
        self >= start && self <= end
    }
}
