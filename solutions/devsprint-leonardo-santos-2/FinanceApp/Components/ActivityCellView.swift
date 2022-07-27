//
//  ActivityCellView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit
import Lottie
import Cartography

final class ActivityCellView: UITableViewCell {
    
    //MARK: - Properties
    private var acessoryViewIsSelected: Bool = false
    
    //MARK: - UI Components
    private var mainStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return stack
    }()
    
    private var labelsStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "bag.circle.fill")
        imageView.tintColor = .systemPurple
        return imageView
    }()
    
    private lazy var activityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Mall"
        return label
    }()
    
    private lazy var activityInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "$100.00 • 8:57 AM"
        return label
    }()
    
    private lazy var accessoryViewAnimated: AnimationView = {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(accessotyViewHandleTapped)
        )
        let av = AnimationView(name: "devpass_button_like")
        av.addGestureRecognizer(tapGesture)
        av.frame = .init(
            x: .zero, y: .zero,
            width: Constant.accessorySize,
            height: Constant.accessorySize
        )
        return av
    }()
    
    //MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper
    
    private func commomInit() {
        configureViewCode()
    }
    
    private func performAnimation(_ playAnimation: Bool) {
        let from: TimeInterval = !playAnimation ? Constant.startFrame : Constant.endFrame
        let to: TimeInterval = !playAnimation ? Constant.endFrame : Constant.startFrame
        acessoryViewIsSelected = !playAnimation
        accessoryViewAnimated.play(fromProgress: from, toProgress: to, loopMode: .playOnce)
    }
    
    //MARK: - Selector
    @objc private func accessotyViewHandleTapped() {
        performAnimation(acessoryViewIsSelected)
    }
}

//MARK: - ViewCodeProtocol
extension ActivityCellView: ViewCodeProtocol {
    
    func configureHierarcy() {
        addSubview(mainStackView)
        
        [categoryImageView, labelsStackView]
            .forEach(mainStackView.addArrangedSubview)
        
        [activityNameLabel, activityInfoLabel]
            .forEach(labelsStackView.addArrangedSubview)
    }
    
    func configureConstraint() {
        
        constrain(self, mainStackView) {
            $1.safeAreaLayoutGuide.edges == $0.safeAreaLayoutGuide.edges
        }
        
        constrain(categoryImageView) {
            $0.height == Constant.imageSize
            $0.width == Constant.imageSize
        }
    }
    
    func configureStyle() {
        contentView.isHidden = true
        accessoryView = accessoryViewAnimated
    }
}

private extension ActivityCellView {
    struct Constant {
        static let imageSize: CGFloat = 50
        static let accessorySize: CGFloat = 40
        static let startFrame: TimeInterval = 0
        static let endFrame: TimeInterval = 1
    }
}


protocol ViewCodeProtocol {
    func configureViewCode()
    func configureStyle()
    func configureHierarcy()
    func configureConstraint()
}

extension ViewCodeProtocol {
    func configureViewCode() {
        configureStyle()
        configureHierarcy()
        configureConstraint()
    }
    
    func configureStyle() {  }
}
