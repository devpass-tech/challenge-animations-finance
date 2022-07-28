//
//  ConfirmationViewController.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit

final class ConfirmationViewController: UIViewController {

    private lazy var confirmationView: ConfirmationView = {
        let confirmationView = ConfirmationView()
        confirmationView.delegate = self
        return confirmationView
    }()
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = confirmationView
    }
}

//MARK: - ConfirmationViewDelegate
extension ConfirmationViewController: ConfirmationViewDelegate {
    func didPressConfirmationButton(_ view: ConfirmationView) {
        dismiss(animated: true)
    }
}
