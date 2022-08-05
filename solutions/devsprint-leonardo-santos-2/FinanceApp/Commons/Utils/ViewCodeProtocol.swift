//
//  ViewCodeProtocol.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 28/07/22.
//

protocol ViewCodeProtocol {
    func configureViewCode()
    func configureStyle()
    func configureHierarchy()
    func configureConstraints()
}

extension ViewCodeProtocol {
    func configureViewCode() {
        configureStyle()
        configureHierarchy()
        configureConstraints()
    }
    
    func configureStyle() {  }
}
