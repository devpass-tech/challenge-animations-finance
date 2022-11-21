import Cartography
import UIKit

final class HeaderCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
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
}

extension HeaderCell: ViewCodable {
    func setupSubviews() {
        addSubview(background)
    }
    
    func setupConstraints() {
        constrain(background, self) {
            $0.leading == $1.leading + 16
            $0.trailing == $1.trailing - 16
            $0.top == $1.top
            $0.bottom == $1.bottom
            
            $0.height == 164
        }
    }
}
