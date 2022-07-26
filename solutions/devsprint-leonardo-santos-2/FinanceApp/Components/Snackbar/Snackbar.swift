//
//  Snackbar.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 25/07/22.
//

import UIKit

final class Snackbar: UIView {
    
    private var state: State { didSet { uptdate() } }
    
    private var initialPosition: CGFloat = .zero
    private var position: VerticalPosition = .top
    private var fadeAnimator: FadeAnimatorProtocol
    private var positionAnimator: PositionAnimatorProtocol
    
    //MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = Constant.horizontalStackSpacing
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Initializers
    init(
        fadeAnimator: FadeAnimatorProtocol = FadeAnimator(),
        positionAnimator: PositionAnimatorProtocol = PositionAnimator()
    ) {
        self.state = .none
        self.fadeAnimator = fadeAnimator
        self.positionAnimator = positionAnimator
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.coderInititlizer)
    }
    
    //MARK: - Methods
    func show(
        on superView: UIView,
        with state: State = .none,
        at position: VerticalPosition = .top
    ) {
        self.state = state
        self.position = position
        animateShowEvent(on: superView)
        initialPosition = configureInitialPosition(at: position)
    }
    
    private func configureInitialPosition(at position: VerticalPosition) -> CGFloat {
        switch self.position {
        case .top:
            return frame.minY + frame.height + Constant.initialPositionPadding
        case .bottom:
            let pOnSuperView = superview!.frame.maxY - (-frame.minY)
            return pOnSuperView - Constant.initialPositionPadding
        }
    }
    
    //MARK: - Helpers
    private func commonInit() {
        configureViewCode()
        fadeAnimator.delegate = self
    }
    
    private func configureViewCode() {
        configureHierarchy()
        configureConstraints()
        configureGesture()
        configureStyle()
    }
    
    private func configureHierarchy() {
        [iconImageView, descriptionLabel, UIView()].forEach(horizontalStackView.addArrangedSubview)
        addSubview(horizontalStackView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: Constant.iconWidth),
            
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.verticalPadding),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.horizontalPadding),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.horizontalPadding),
            horizontalStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constant.minComponentHeight),
            
            bottomAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: Constant.verticalPadding),
        ])
    }
    
    private func configureStyle() {
        layer.cornerRadius = Constant.componentCornerRadius
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dragGestureHandler))
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }
    
    private func uptdate() {
        iconImageView.image = state.icon
        descriptionLabel.text = state.description
        backgroundColor = state.backgroundColor
    }
    
    private func configureSnackbarPosition(on superView: UIView, at position: VerticalPosition) {
        configureAnchorVerticalPosition(on: superView, at: position)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(
                equalTo: superView.leadingAnchor,
                constant: Constant.superviewHorizontalPadding
            ),
            
            trailingAnchor.constraint(
                equalTo: superView.trailingAnchor,
                constant: -Constant.superviewHorizontalPadding
            )
        ])
        
        layoutIfNeeded()
    }
    
    private func configureAnchorVerticalPosition(on superView: UIView, at position: VerticalPosition) {
        let anchor: NSLayoutConstraint
        switch position {
        case .top:
            anchor = topAnchor.constraint(
                equalTo: superView.safeAreaLayoutGuide.topAnchor,
                constant: -frame.height
            )
        case .bottom:
            anchor = bottomAnchor.constraint(
                equalTo: superView.safeAreaLayoutGuide.bottomAnchor,
                constant: frame.height
            )
        }
        anchor.isActive = true
    }
    
    private func animateShowEvent(on superView: UIView) {
        superView.addSubview(self)
        configureSnackbarPosition(on: superView, at: position)
        animateInitialStateAlpha()
        animateSnackbarInPosition()
        animateDimissalHandler()
    }
    
    private func animateDimissalHandler() {
        Timer.scheduledTimer(
            withTimeInterval: Constant.waitTimeToDismiss,
            repeats: false
        ) { [weak self] _ in
            guard let self = self else { return }
            self.animateHideSnackbar()
        }
    }
    
    private func animateHideSnackbar() {
        self.animateEndedOpacity()
        self.animateDismissalPosition()
    }
    
    private func animateEndedOpacity() {
        fadeAnimator.option = .out
        fadeAnimator.animate(self)
    }
    
    private func animateDismissalPosition() {
        positionAnimator.option = .out
        positionAnimator.position = position
        positionAnimator.animate(self)
    }
    
    private func animateInitialStateAlpha() {
        fadeAnimator.option = .in
        fadeAnimator.animate(self)
    }
    
    private func animateSnackbarInPosition() {
        positionAnimator.position = position
        positionAnimator.animate(self)
    }
    
    //MARK: - Selector
    @objc private func dragGestureHandler(_ sender: UIPanGestureRecognizer) {
        guard let superView = superview else { return }
        
        let dragPosition = sender.translation(in: superView)
        let currentPosition: CGFloat = dragPosition.y + initialPosition

        gestureStateHandler(sender.state, in: currentPosition)
    }
    
    private func gestureStateHandler(_ state: UIGestureRecognizer.State, in currentPosition: CGFloat) {
        switch state {
        case .changed: gestureStateChangedHandler(in: currentPosition)
        case.ended: gestureStateEndedHander(in: currentPosition)
        default: break
        }
    }
    
    private func gestureStateChangedHandler(in currentPosition: CGFloat) {
        switch position {
        case .top:
            guard currentPosition < initialPosition else { return }
            frame.origin.y = currentPosition
        case .bottom:
            guard currentPosition > initialPosition else { return }
            frame.origin.y = currentPosition
        }
    }
    
    private func gestureStateEndedHander(in currentPosition: CGFloat) {
        switch position {
        case .top:
            guard currentPosition > initialPosition - frame.height else {
                animateHideSnackbar()
                return
            }
            resetSnackbarPosition()
            
        case .bottom:
            guard currentPosition < initialPosition + frame.height else {
                animateHideSnackbar()
                return
            }
            resetSnackbarPosition()
        }
    }
    
    private func resetSnackbarPosition() {
        frame.origin.y = initialPosition
    }
}

//MARK: - FadeAnimatorDelegate
extension Snackbar: FadeAnimatorDelegate {
    func fadeAnimationCompleted(_ view: UIView, on stage: AnimationStage, animator: FadeAnimatorProtocol) {
        guard stage == .out else { return }
        removeFromSuperview()
    }
}
