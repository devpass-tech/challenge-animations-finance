import UIKit

private extension NikeView.Layout {
    enum Size {
        static let logoSize: CGSize = .init(width: 200, height: 200)
    }
}

final class NikeView: UIView {
    // MARK: - Property(ies).
    fileprivate enum Layout {}
    
    // MARK: - Component(s).
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "air-jordan-2")
        imageView.transform = .init(scaleX: 100, y: 100)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization(s).
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NikeView {
    // MARK: - Animation(s).
    private func animate() {
        UIView.animate(withDuration: 2.75, delay: 0.5, options: .curveEaseOut) {
            self.logo.transform = .init(scaleX: 0.01, y: 0.01)
        } completion: { _ in
            self.logo.removeFromSuperview()
            self.backgroundColor = .white
        }
    }
}

// MARK: - ViewCodable.
extension NikeView: ViewCodable {
    func setupSubviews() {
        addSubview(logo)
    }
    
    func setupConstraints() {
        logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logo.heightAnchor.constraint(equalToConstant: Layout.Size.logoSize.height).isActive = true
        logo.widthAnchor.constraint(equalToConstant: Layout.Size.logoSize.width).isActive = true
    }
    
    func setupExtraConfiguration() {
        animate()
    }
}
