import UIKit

final class FlipViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
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
