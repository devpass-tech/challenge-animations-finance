//
//  LoadableButton.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit
import Lottie
import Cartography

protocol LoadableButtonDelegate: AnyObject {
    func mainButtonHandleTapped(_ button: LoadableButton, with state: LoadableButton.State)
}

final class LoadableButton: UIButton {
    
    //MARK: - Properties
    weak var delegate: LoadableButtonDelegate?
    
    private let title: String
    private(set) var buttonState: State {
        didSet{ updateState() }
    }
    
    //MARK: - UI Components
    private lazy var loaderAnimatedView: AnimationView = {
        let av = AnimationView(name: LottieFile.circleLoading.file)
        av.contentMode = .scaleAspectFill
        av.loopMode = .loop
        av.animationSpeed = Constant.animationSpeed
        av.play()
        av.isHidden = true
        return av
    }()
    
    //MARK: - Initializers
    init(
        state: State = .ready,
        title: String = Constant.defaultTitle
    ) {
        self.buttonState = state
        self.title = title
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.buttonState = .ready
        self.title = Constant.defaultTitle
        super.init(frame: .zero)
        commonInit()
    }
    
    //MARK: - Methods
    func setState(to state: State) {
        self.buttonState = state
    }
    
    //MARK: - Helpers
    
    private func commonInit() {
        configureStyle()
        configureHierarcy()
        configureConstraints()
        configureAction()
    }
    
    private func configureHierarcy() {
        addSubview(loaderAnimatedView)
    }
    
    private func configureConstraints() {
        constrain(self, loaderAnimatedView) {
            $1.centerX == $0.centerX
            $1.centerY == $0.centerY
            $1.height == Constant.loadingImageSize
            $1.width == Constant.loadingImageSize
            
            $0.height == Constant.buttonHeight
        }
    }
    
    private func configureStyle() {
        setTitle(title, for: .normal)
        layer.cornerRadius = Constant.buttonCornerRadius
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
    }
    
    private func configureAction() {
        addTarget(self, action: #selector(mainButtonHandleTapped), for: .touchUpInside)
    }
    
    private func updateState() {
        handleButtonFor(isReady: buttonState == .ready)
    }
    
    private func handleButtonFor(isReady: Bool) {
        let buttonTitle: String? = isReady ? title : nil
        
        loaderAnimatedView.isHidden = isReady
        setTitle(buttonTitle, for: .normal)
        isEnabled = isReady
    }
    
    //MARK: - Selctor
    @objc private func mainButtonHandleTapped(_ sender: UIButton) {
        delegate?.mainButtonHandleTapped(self, with: buttonState)
    }
    
    private struct Constant {
        static let defaultTitle = "Action"
        static let animationSpeed: CGFloat = 0.8
        static let buttonCornerRadius: CGFloat = 14
        static let buttonHeight: CGFloat = 56
        static let loadingImageSize: CGFloat = 45
    }
}
