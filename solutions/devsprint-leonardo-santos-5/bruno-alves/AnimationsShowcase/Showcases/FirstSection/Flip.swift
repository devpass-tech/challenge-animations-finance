import UIKit

final class FlipViewController: BaseViewController {
    
    // MARK: - Private Properties
    
    private var isOpen = false
    
    // MARK: - Actions
    
    override func didTapActionButton() {
        if isOpen {
            isOpen = false
            UIView.transition(with: square, duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
        } else {
            isOpen = true
            UIView.transition(with: square, duration: 0.3, options: .transitionFlipFromRight, animations: nil)
        }
    }
}

struct FlipShowcase: ShowcaseRow {
    var title: String {
        "Flip"
    }
    
    var description: String {
        "Implementação de uma animação de flip numa view"
    }
    
    var destination: UIViewController {
        let vc = FlipViewController()
        vc.title = title
        return vc
    }
}
