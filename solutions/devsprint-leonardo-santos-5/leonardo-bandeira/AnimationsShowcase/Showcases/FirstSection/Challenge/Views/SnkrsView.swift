import UIKit

final class SnkrsView: UIView {
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

// MARK: - ViewCodable.
extension SnkrsView: ViewCodable {
    func setupSubviews() {}
    
    func setupConstraints() {}
    
    func setupExtraConfiguration() {
        backgroundColor = .systemBackground
    }
}
