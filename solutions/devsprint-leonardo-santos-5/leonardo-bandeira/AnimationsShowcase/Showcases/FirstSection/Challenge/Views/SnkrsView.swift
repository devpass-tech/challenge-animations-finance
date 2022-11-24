import UIKit

private extension SnkrsView.Layout {
    enum Size {
        static let logoSize: CGSize = .init(width: 200, height: 200)
    }
}

final class SnkrsView: UIView {
    // MARK: - Property(ies).
    fileprivate enum Layout {}
    
    // MARK: - Component(s).
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "snkrs-logo")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
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

// MARK: - Animation(s).
private extension SnkrsView {
    private func animate() {
        UIView.animate(withDuration: 1.75, delay: 0) {
            self.logo.transform = .init(scaleX: 0.01, y: 0.01)
        } completion: { _ in
            self.logo.removeFromSuperview()
            self.backgroundColor = .white
        }
    }
}

// MARK: - ViewCodable.
extension SnkrsView: ViewCodable {
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
        backgroundColor = UIColor(red: 1.00, green: 0.00, blue: 0.09, alpha: 1.00)
        animate()
    }
}
