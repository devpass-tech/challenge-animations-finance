import Cartography
import UIKit

final class HomeCell: UITableViewCell {
    
    // MARK: - UI Element
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 16
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView(image: .init(systemName: "chevron.right"))
        image.tintColor = .systemGray3
        return image
    }()
    
    // MARK: - Setup

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }

    // MARK: - Render

    func render(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

extension HomeCell: ViewCodable {
    func setupSubviews() {
        addSubview(hStack)
        
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(icon)
    
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        constrain(hStack, self) {
            $0.leading == $1.leading + 16
            $0.trailing == $1.trailing - 16
            $0.top == $1.top + 16
            $0.bottom == $1.bottom - 16
        }

        constrain(icon) {
            $0.width == 12
        }
    }
}
