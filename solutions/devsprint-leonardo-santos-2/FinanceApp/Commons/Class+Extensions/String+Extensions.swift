//
//  String+Extensions.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

extension String {
    var devpass: StringHelper { .init(support: self) }
    
    struct StringHelper {
        let support: String
        
        init(support: String) {
            self.support = support
        }
        
        func toDate(with format: DateFormat = .format1) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.date(from: support)
        }
    }
}
