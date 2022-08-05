//
//  TransfersViewController.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit
import Hero

class TransfersViewController: UIViewController {

    lazy var transferView: TransfersView = {

        let transferView = TransfersView()
        transferView.delegate = self
        return transferView
    }()

    override func loadView() {
        self.view = transferView
    }
}

extension TransfersViewController: TransferViewDelegate {

    func didPressChooseContactButton() {

        let contactListViewController = ContactListViewController()
        contactListViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: contactListViewController)
        self.present(navigationController, animated: true)
    }

    func didPressTransferButton(with amount: String) {
        let viewController = ConfirmationViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.hero.isEnabled = true
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

extension TransfersViewController: ContactListViewControllerDelegate {

    func didSelectContact() {

        self.dismiss(animated: true)

        let alertViewController = UIAlertController(title: "Contact selection", message: "A contact was selected", preferredStyle: .alert)
        let action = UIAlertAction(title: "Thanks", style: .default)
        alertViewController.addAction(action)
        self.present(alertViewController, animated: true)
    }
}
