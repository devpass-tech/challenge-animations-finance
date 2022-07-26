//
//  ConfirmationView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit
import Hero
import Cartography

protocol ConfirmationViewDelegate: AnyObject {
    func didPressConfirmationButton(_ view: ConfirmationView)
}

final class ConfirmationView: UIView {
    
    //MARK: - Properties
    weak var delegate: ConfirmationViewDelegate?
    
    //MARK: - UI Components
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constant.stackSpacing
        return stackView
    }()
    
    private lazy var confirmationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constant.confirmIcon
        return imageView
    }()
    
    private lazy var confirmationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = Constant.confirmDescription
        label.font = UIFont.boldSystemFont(ofSize: Constant.confirmDescriptionFontSize)
        return label
    }()
    
    lazy var confirmationButton: LoadableButton = {
        let button = LoadableButton(state: .ready, title: "Nice!")
        button.backgroundColor = .white
        button.setTitleColor(.devpass.successGreen, for: .normal)
        button.delegate = self
        return button
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.coderInit)
    }
    
    //MARK: - Helpers
    private func commonInit() {
        configureViewCode()
        configureHero()
    }
    
    private func configureHero() {
        heroID = Constant.heroID
        hero.isEnabled = true
    }
    
    //MARK: - Selctors
    @objc private func confirmationButtonPressed() {
        delegate?.didPressConfirmationButton(self)
    }
}

//MARK: - ViewCodeProtocol
extension ConfirmationView: ViewCodeProtocol {
    func configureHierarchy() {
        [confirmationImageView, confirmationLabel].forEach(stackView.addArrangedSubview)
        [stackView, confirmationButton].forEach(addSubview)
    }
    
    func configureConstraints() {
        constrain(self, stackView) {
            $1.centerX == $0.centerX
            $1.centerY == $0.centerY
            $1.leading == $0.leading + Constant.horizontalPadding
            $1.trailing == $0.trailing - Constant.horizontalPadding
        }
        
        constrain(confirmationImageView) {
            $0.height == Constant.iconSize
            $0.width == $0.height
        }
        
        constrain(self, confirmationButton) {
            $1.leading == $0.leading + Constant.horizontalPadding
            $1.trailing == $0.trailing - Constant.horizontalPadding
            $1.bottom == $0.safeAreaLayoutGuide.bottom - Constant.verticalPadding
            $1.height == Constant.buttonHeight
        }
    }
    
    func configureStyle() {
        backgroundColor = .devpass.successGreen
    }
}

//MARK: - Constant
private extension ConfirmationView {
    struct Constant {
        static let confirmIcon = SFSymbols.checkCircleFilled.image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        static let confirmDescription = "Your transfer was successful"
        static let confirmDescriptionFontSize: CGFloat = 17
        static let buttonTitle = "Nice!"
        static let buttonCornerRadius: CGFloat = 14
        static let heroID = "TransferButton"
        static let coderInit = "init(coder:) has not been implemented"
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 20
        static let buttonHeight: CGFloat = 56
        static let iconSize: CGFloat = 100
        static let stackSpacing: CGFloat = 8
    }
}

//MARK: - LoadableButtonDelegate
extension ConfirmationView: LoadableButtonDelegate {
    func mainButtonHandleTapped(_ button: LoadableButton, with state: LoadableButton.State) {
        delegate?.didPressConfirmationButton(self)
    }
}
