import UIKit

final class FlipViewController: BaseViewController {
    override func didTapActionButton() {
        UIView.transition(with: square,
                          duration: 1.5,
                          options: [.autoreverse, .repeat, .transitionFlipFromRight],
                          animations: nil)
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
