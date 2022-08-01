//
//  ActivityCellView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit
import SkeletonView

class ActivityCellView: UITableViewCell {

   private var mainStackView: UIStackView = {
       let stack = UIStackView(frame: .zero)
       stack.translatesAutoresizingMaskIntoConstraints = false
       stack.spacing = 8
       stack.alignment = .center
       stack.isLayoutMarginsRelativeArrangement = true
       stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
       stack.isSkeletonable = true
       return stack
    }()

    private var labelsStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.isSkeletonable = true
        return stack
    }()

    lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "bag.circle.fill")
        imageView.tintColor = .systemPurple
        imageView.isSkeletonable = true
        return imageView
    }()

    lazy var activityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Mall"
        label.isSkeletonable = true
        return label
    }()

    lazy var activityInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "$100.00 • 8:57 AM"
        label.isSkeletonable = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator

        addSubviews()
        configureConstraints()
        activityCellsSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.hideActivityCellsSkeleton()
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActivityCellView {

    func addSubviews() {

        addSubview(mainStackView)
        mainStackView.addArrangedSubview(categoryImageView)
        mainStackView.addArrangedSubview(labelsStackView)

        labelsStackView.addArrangedSubview(activityNameLabel)
        labelsStackView.addArrangedSubview(activityInfoLabel)
    }

    func configureConstraints() {

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            self.categoryImageView.widthAnchor.constraint(equalToConstant: 50),
            self.categoryImageView.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
    
    func activityCellsSkeleton(){
        mainStackView.showAnimatedGradientSkeleton()
        labelsStackView.showAnimatedGradientSkeleton()
        categoryImageView.showAnimatedGradientSkeleton()
        activityNameLabel.showAnimatedGradientSkeleton()
        activityInfoLabel.showAnimatedGradientSkeleton()
    }
    
    func hideActivityCellsSkeleton(){
        mainStackView.hideSkeleton()
        labelsStackView.hideSkeleton()
        categoryImageView.hideSkeleton()
        activityNameLabel.hideSkeleton()
        activityInfoLabel.hideSkeleton()
    }
}
