import UIKit

protocol AirJordanDelegate: AnyObject {
    func airJordanCompletion()
}

private extension AirJordanView.Layout {
    enum Size {
        static let logoSize: CGSize = .init(width: 200, height: 200)
    }
}

final class AirJordanView: UIView {
    // MARK: - Property(ies).
    fileprivate enum Layout {}
    weak var delegate: AirJordanDelegate?
    
    // MARK: - Component(s).
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "air-jordan")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(red: 1.00, green: 0.00, blue: 0.09, alpha: 1.00)
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

private extension AirJordanView {
    // MARK: - Animation(s).
    private func animate() {
        UIView.animate(withDuration: 2.4, delay: 0.0, options: .curveEaseOut) {
            self.logo.transform = .init(scaleX: 0.01, y: 0.01)
        } completion: { _ in
            self.backgroundColor = UIColor(red: 1.00, green: 0.00, blue: 0.09, alpha: 1.00)
            self.delegate?.airJordanCompletion()
            self.logo.removeFromSuperview()
        }
    }
}

// MARK: - ViewCodable.
extension AirJordanView: ViewCodable {
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
