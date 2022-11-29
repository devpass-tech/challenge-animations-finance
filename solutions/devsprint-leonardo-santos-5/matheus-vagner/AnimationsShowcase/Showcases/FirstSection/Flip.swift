import UIKit

final class FlipViewController: BaseViewController {
    private var allReadyTouch = false
    
    private func topBottomFlip() {
        UIView.transition(with: square, duration: 0.5, options: .transitionFlipFromTop, animations: nil) { _ in
            UIView.transition(with: self.square, duration: 0.5, options: .transitionFlipFromBottom, animations: nil) { _ in
                self.actionButton.isEnabled = true
            }
        }
    }
    
    private func leftRightFlip() {
        UIView.transition(with: square, duration: 0.5, options: .transitionFlipFromLeft, animations: nil) { _ in
            UIView.transition(with: self.square, duration: 0.5, options: .transitionFlipFromRight, animations: nil) { _ in
                self.topBottomFlip()
            }
        }
    }
    
    override func didTapActionButton() {
        self.actionButton.isEnabled = false
        leftRightFlip()
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
