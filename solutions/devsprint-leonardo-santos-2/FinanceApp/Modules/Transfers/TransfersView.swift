//
//  TransfersView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import Foundation
import UIKit

protocol TransferViewDelegate: AnyObject {

    func didPressChooseContactButton()
    func didPressTransferButton(with amount: String)
}

class TransfersView: UIView {

    weak var delegate: TransferViewDelegate?

    let stackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "$0"
        textField.font = UIFont.boldSystemFont(ofSize: 34)
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        return textField
    }()

    lazy var chooseContactButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choose contact", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(chooseContact), for: .touchUpInside)
        return button
    }()
    
    lazy var transferButton: LoadableButton = {
        let button = LoadableButton(state: .ready, title: "Transfer!")
        button.backgroundColor = .systemBlue
        button.delegate = self
        return button
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .white

        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(chooseContactButton)

        addSubview(stackView)
        addSubview(transferButton)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),

            transferButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            transferButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            transferButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            transferButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    @objc
    func chooseContact() {

        delegate?.didPressChooseContactButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - LoadableButtonDelegate
extension TransfersView: LoadableButtonDelegate {
    func mainButtonHandleTapped(_ button: LoadableButton, with state: LoadableButton.State) {
        button.setState(to: .loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            button.setState(to: .ready)
            self.delegate?.didPressTransferButton(with: self.amountTextField.text ?? "0")
        }
    }
}
