//
//  HomeHeaderView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import Foundation
import UIKit
import SkeletonView

class HomeHeaderView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isSkeletonable = true
        return stackView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "$15,459.27"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.isSkeletonable = true
        return label
    }()

    let savingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.isSkeletonable = true
        return stackView
    }()

    let savingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Savings"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.isSkeletonable = true
        return label
    }()

    let savingsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$100.00"
        label.textColor = .lightGray
        label.isSkeletonable = true
        return label
    }()

    let spendingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.isSkeletonable = true
        return stackView
    }()

    let spendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Spending"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.isSkeletonable = true
        return label
    }()

    let spendingValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$100.00"
        label.textColor = .lightGray
        label.isSkeletonable = true
        return label
    }()
    
    func skeletonHomeHeader(){
        stackView.showAnimatedGradientSkeleton()
        label.showAnimatedGradientSkeleton()
        savingsStackView.showAnimatedGradientSkeleton()
        savingsLabel.showAnimatedGradientSkeleton()
        savingsValueLabel.showAnimatedGradientSkeleton()
        spendingStackView.showAnimatedGradientSkeleton()
        spendingLabel.showAnimatedGradientSkeleton()
        spendingValueLabel.showAnimatedGradientSkeleton()
    }
    
    func hideSkeletonHomeHeader(){
        stackView.hideSkeleton()
        label.hideSkeleton()
        savingsStackView.hideSkeleton()
        savingsLabel.hideSkeleton()
        savingsValueLabel.hideSkeleton()
        spendingStackView.hideSkeleton()
        spendingLabel.hideSkeleton()
        spendingValueLabel.hideSkeleton()
    }

    init() {
        super.init(frame: .zero)

        backgroundColor = .white

        savingsStackView.addArrangedSubview(savingsLabel)
        savingsStackView.addArrangedSubview(savingsValueLabel)

        spendingStackView.addArrangedSubview(spendingLabel)
        spendingStackView.addArrangedSubview(spendingValueLabel)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(savingsStackView)
        stackView.addArrangedSubview(spendingStackView)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
