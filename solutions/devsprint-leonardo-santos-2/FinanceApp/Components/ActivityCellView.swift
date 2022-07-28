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
    private(set) var acessoryViewIsSelected: Bool = false
    
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
    
    private lazy var accessoryViewAnimated: AnimationView = {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(accessotyViewHandleTapped)
        )
        let av = AnimationView(name: LottieFile.like.file)
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
        performAnimation(acessoryViewIsSelected)
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

enum LottieFile: String {
    case like = "devpass_button_like"
    
    var file: String { rawValue }
}
