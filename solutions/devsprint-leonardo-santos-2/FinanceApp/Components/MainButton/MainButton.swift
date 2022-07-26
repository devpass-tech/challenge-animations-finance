//
//  MainButton.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit
import Lottie

protocol MainButtonDelegate: AnyObject {
    func mainButtonHandleTapped(_ button: MainButton, with state: MainButton.State)
}

final class MainButton: UIButton {
    
    //MARK: - Properties
    weak var delegate: MainButtonDelegate?
    
    private let title: String
    private(set) var buttonState: State {
        didSet{ updateState() }
    }
    
    //MARK: - UI Components
    private lazy var loaderAnimatedView: AnimationView = {
        let av = AnimationView(name: LottieFiles.circleLoading.file)
        av.contentMode = .scaleAspectFill
        av.loopMode = .loop
        av.animationSpeed = Constant.animationSpeed
        av.play()
        av.isHidden = true
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()
    
    //MARK: - Initializers
    init(state: State = .ready, title: String = Constant.defaultTitle) {
        self.buttonState = state
        self.title = title
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.coderInit)
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
        NSLayoutConstraint.activate([
            loaderAnimatedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderAnimatedView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loaderAnimatedView.heightAnchor.constraint(equalToConstant: Constant.loadingImageSize),
            loaderAnimatedView.widthAnchor.constraint(equalToConstant: Constant.loadingImageSize),
            
            heightAnchor.constraint(equalToConstant: Constant.buttonHeight)
        ])
    }
    
    private func configureStyle() {
        setTitle(title, for: .normal)
        layer.cornerRadius = Constant.buttonCornerRadius
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
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
        static let coderInit = "init(coder:) has not been implemented"
        static let defaultTitle = "Action"
        static let animationSpeed: CGFloat = 0.8
        static let buttonCornerRadius: CGFloat = 8
        static let buttonHeight: CGFloat = 50
        static let loadingImageSize: CGFloat = 45
    }
}

enum LottieFiles: String {
    case circleLoading = "devpass_button_loading"
    
    var file: String { rawValue }
}
