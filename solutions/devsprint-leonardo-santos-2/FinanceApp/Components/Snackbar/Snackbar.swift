//
//  Snackbar.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 25/07/22.
//

import UIKit

final class Snackbar: UIView {
    
    private var viewData: ViewData = .init() {
        didSet { viewDataHandler() }
    }
    
    //MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func show(
        on superView: UIView,
        with viewData: ViewData = .init(),
        at position: Position = .top
    ) {
        self.viewData = viewData
        animateShowEvent(on: superView, at: position)
    }
    
    private func animateShowEvent(
        on superView: UIView,
        at position: Position
    ) {
        configureSnackbarInitialPostion(from: superView, at: position)
        animateSnackbarAlpha()
        animateSnackbarMoviment(at: position)
        animateDimissalHandler(at: position)
    }
    
    private func animateDimissalHandler(at position: Position) {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            
            self.animateDismissalOpacity()
            self.animateDismissalMoviment(at: position)
        }
    }
    
    private func animateDismissalOpacity() {
        alpha = 1
        UIView.animate(
            withDuration: 0.4, delay: .zero, options: [],
            animations: { self.alpha = 0 },
            completion: { _ in }
        )
    }
    
    private func animateDismissalMoviment(at position: Position) {
        UIView.animate(
            withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8,
            initialSpringVelocity: .zero, options: [.curveEaseIn]
        ) {
            switch position {
            case .top:
                self.frame.origin.y -= self.frame.height
            case .bottom:
                self.frame.origin.y += self.frame.height
            }
        } completion: { _ in }
    }
    
    private func animateSnackbarAlpha() {
        alpha = 0
        UIView.animate(
            withDuration: 0.2, delay: .zero, options: [],
            animations: { self.alpha = 1 },
            completion: { _ in }
        )
    }
    
    private func configureSnackbarInitialPostion(from superView: UIView, at position: Position) {
        superView.addSubview(self)
        
        switch position {
        case .top:
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: -frame.height).isActive = true
        case .bottom:
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: +frame.height).isActive = true
        }
        
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 10).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -10).isActive = true
        layoutIfNeeded()
    }
    
    private func animateSnackbarMoviment(at position: Position) {
        UIView.animate(
            withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8,
            initialSpringVelocity: .zero, options: [.curveEaseIn]
        ) {
            switch position {
            case .top:
                self.frame.origin.y += self.frame.height
            case .bottom:
                self.frame.origin.y -= self.frame.height
            }
        } completion: { _ in }
    }
    
    //MARK: - Helpers
    private func commonInit() {
        configureViewCode()
    }
    
    private func configureViewCode() {
        configureHierarchy()
        configureConstraints()
        configureStyle()
    }
    
    private func configureHierarchy() {
        [iconImageView, descriptionLabel, UIView()].forEach(horizontalStackView.addArrangedSubview)
        addSubview(horizontalStackView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 26),
            
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10),
        ])
    }
    
    private func configureStyle() {
        layer.cornerRadius = 8
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func viewDataHandler() {
        viewDataImageHandler()
        viewDataDescriptionHandler()
        viewDataStateHandler()
    }
    
    private func viewDataImageHandler() {
        let image = viewData.symbol.image
        iconImageView.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
    
    private func viewDataDescriptionHandler() {
        let description = viewData.description
        descriptionLabel.text = description
    }
    
    private func viewDataStateHandler() {
        switch viewData.state {
        case .success:
            backgroundColor = .green
        case .failure:
            backgroundColor = .red
        }
    }
}
