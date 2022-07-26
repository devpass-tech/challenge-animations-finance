//
//  Snackbar.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 25/07/22.
//

import UIKit

final class Snackbar: UIView {
    
    private var state: State { didSet { uptdate() } }
    private var fadeAnimator: FadeAnimatorProtocol
    private var positionAnimator: PositionAnimatorProtocol
    private var dragGesture: DragGestureProtocol?
    
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
        animateShowEvent(on: superView, at: position)
        var gesture = SnackDragGestureHandler(reference: self, at: position)
        gesture.delegate = self
        dragGesture = gesture
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
    
    private func animateShowEvent(on superView: UIView, at position: VerticalPosition) {
        superView.addSubview(self)
        configureSnackbarPosition(on: superView, at: position)
        animateInitialStateAlpha()
        animateSnackbarInPosition(at: position)
        animateDimissalHandler(at: position)
    }
    
    private func animateDimissalHandler(at position: VerticalPosition) {
        Timer.scheduledTimer(
            withTimeInterval: Constant.waitTimeToDismiss,
            repeats: false
        ) { [weak self] _ in
            guard let self = self else { return }
            self.animateHideSnackbar(at: position)
        }
    }
    
    private func animateHideSnackbar(at position: VerticalPosition) {
        self.animateEndedOpacity()
        self.animateDismissalPosition(at: position)
    }
    
    private func animateEndedOpacity() {
        fadeAnimator.option = .out
        fadeAnimator.animate(self)
    }
    
    private func animateDismissalPosition(at position: VerticalPosition) {
        positionAnimator.option = .out
        positionAnimator.position = position
        positionAnimator.animate(self)
    }
    
    private func animateInitialStateAlpha() {
        fadeAnimator.option = .in
        fadeAnimator.animate(self)
    }
    
    private func animateSnackbarInPosition(at position: VerticalPosition) {
        positionAnimator.position = position
        positionAnimator.animate(self)
    }
    
    //MARK: - Selector
    @objc private func dragGestureHandler(_ sender: UIPanGestureRecognizer) {
        dragGesture?.handle(self, for: sender)
    }
}

//MARK: - FadeAnimatorDelegate
extension Snackbar: FadeAnimatorDelegate {
    func fadeAnimationCompleted(_ view: UIView, on stage: AnimationStage, animator: FadeAnimatorProtocol) {
        guard stage == .out else { return }
        removeFromSuperview()
    }
}

//MARK: - DragGestureHandlerDelegate
extension Snackbar: DragGestureHandlerDelegate {
    func dragGestureDismissed(_ view: UIView, at position: VerticalPosition, dragGesture: DragGestureProtocol) {
        animateHideSnackbar(at: position)
    }
}
