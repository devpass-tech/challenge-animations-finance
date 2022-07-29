//
//  Date+Extensions.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

extension Date {
    var devpass: DateHelper { .init(support: self) }
    
    struct DateHelper {
        private let support: Date
        
        init(support: Date) {
            self.support = support
        }
        
        func isBetween(start: Date, end: Date) -> Bool {
            support >= start && support <= end
        }
    }
}
