import Cartography
import UIKit

class BaseViewController: UIViewController {
    private(set) lazy var square: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .devpass
        view.addGestureRecognizer(.init(target: self, action: #selector(didTapActionButton)))
        
        constrain(view) {
            $0.height == 86
            $0.width == 86
        }
        
        return view
    }()
    
    private lazy var actionButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .devpass
        
        let button = UIButton(configuration: config)
        button.setTitle("Animar", for: .normal)
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Public Methods
    
    @objc func didTapActionButton() {}
}

extension BaseViewController: ViewCodable {
    func setupSubviews() {
        [square, actionButton].forEach(view.addSubview)
    }
    
    func setupConstraints() {
        constrain(square, view) {
            $0.center == $1.center
        }
        
        constrain(actionButton, view) {
            $0.bottom == $1.bottom - 64
            $0.leading == $1.leading + 24
            $0.trailing == $1.trailing - 24
            
            $0.height == 50
        }
    }
    
    func setupExtraConfiguration() {
        view.backgroundColor = .systemBackground
    }
}
