import Cartography
import UIKit

final class HomeSectionView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Configuration
    
    func configure(with title: String, and subtitle: String) {
        self.title.text = title
        self.subtitle.text = subtitle
    }
}

extension HomeSectionView: ViewCodable {
    func setupSubviews() {
        [title, subtitle].forEach(addSubview)
    }
    
    func setupConstraints() {
        constrain(title, subtitle, self) { title, subtitle, superView in
            title.leading == superView.leading
            title.trailing == superView.trailing
            title.top == superView.top + 8
            title.bottom == subtitle.top
            
            subtitle.leading == superView.leading
            subtitle.trailing == superView.trailing
            subtitle.bottom == superView.bottom - 8
        }
    }
    
    func setupExtraConfiguration() {
        backgroundColor = .systemBackground
    }
}
