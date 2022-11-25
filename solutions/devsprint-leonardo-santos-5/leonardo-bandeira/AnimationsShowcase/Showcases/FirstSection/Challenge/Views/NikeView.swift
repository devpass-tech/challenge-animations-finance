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
        imageView.image = UIImage(named: "nike-logo")
        imageView.transform = .init(scaleX: 500, y: 500)
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
        UIView.animate(withDuration: 3.5, delay: 0.0, options: .curveEaseOut) {
            self.logo.transform = .init(scaleX: 1, y: 1)
        } completion: { _ in
            self.backgroundColor = UIColor(red: 1.00, green: 0.00, blue: 0.09, alpha: 1.00)
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
