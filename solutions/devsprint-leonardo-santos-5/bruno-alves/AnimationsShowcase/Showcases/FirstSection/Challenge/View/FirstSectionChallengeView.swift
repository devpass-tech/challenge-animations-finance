//
//  FirstSectionChallengeView.swift
//  AnimationsShowcase
//
//  Created by Bruno Silva on 27/11/22.
//

import UIKit

protocol FirstSectionChallengeViewDelegate: AnyObject {
    func didCallAnimation()
}

final class FirstSectionChallengeView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: FirstSectionChallengeViewDelegate?
    
    // MARK: - Properties UI
    
    lazy var cardImageView: UIImageView = {
        let imageName = "backCard.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var changeSideButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .devpass
        let button = UIButton(configuration: config)
        button.setTitle("Animar", for: .normal)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    private func animate() {
        delegate?.didCallAnimation()
    }
}

// MARK: - Extension

extension FirstSectionChallengeView: ViewCodable {
    func setupSubviews() {
        addSubview(cardImageView)
        addSubview(changeSideButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardImageView.heightAnchor.constraint(equalToConstant: 300),
            cardImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            changeSideButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            changeSideButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            changeSideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            changeSideButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .systemBackground
    }
}
