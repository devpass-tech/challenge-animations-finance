//
//  ActivityCellView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit
import Lottie
import Cartography

final class ActivityCellView: UITableViewCell, ReusableCell {
    
    //MARK: - Properties
    var isLiked: Bool { accessoryViewAnimated.animationFinished }
    
    //MARK: - UI Components
    private var mainStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.spacing = Constant.mainStackSpacing
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: .zero, left: Constant.edgeLeftMargin, bottom: .zero, right: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var labelsStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = Constant.mainStackSpacing
        return stack
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constant.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.image = AssetsCatalog.circleBagFilled.image
        imageView.tintColor = .systemPurple
        return imageView
    }()
    
    private lazy var activityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constant.bigFontSize)
        label.text = Constant.activityNameText
        return label
    }()
    
    private lazy var activityInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: Constant.smallFontSize)
        label.text = Constant.activityText
        return label
    }()
    
    private lazy var accessoryViewAnimated: SingleLoopAnimationView = {
        let comp: SingleLoopAnimationView = .default(file: .like, size: Constant.accessorySize)
        comp.delegate = self
        return comp
    }()
    
    //MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        commomInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .default, reuseIdentifier: nil)
        accessoryType = .disclosureIndicator
        commomInit()
    }
    
    //MARK: - Method
    
    func like() {
        accessoryViewAnimated.animate()
    }
    
    //MARK: - Helper
    
    private func commomInit() {
        configureViewCode()
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

//MARK: - SingleLoopAnimationViewDelegate
extension ActivityCellView: SingleLoopAnimationViewDelegate {
    func animationViewHandleTapped(
        _ animationView: SingleLoopAnimationView,
        with animation: AnimationView
    ) {
        animationView.animate()
    }
}

private extension ActivityCellView {
    struct Constant {
        static let smallFontSize: CGFloat = 14
        static let bigFontSize: CGFloat = 17
        static let cornerRadius: CGFloat = 25
        static let edgeLeftMargin: CGFloat = 16
        static let mainStackSpacing: CGFloat = 8
        static let imageSize: CGFloat = 50
        static let accessorySize: CGFloat = 40
        static let startFrame: TimeInterval = 0
        static let endFrame: TimeInterval = 1
        static let activityText = "$100.00 • 8:57 AM"
        static let activityNameText = "Mall"
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
