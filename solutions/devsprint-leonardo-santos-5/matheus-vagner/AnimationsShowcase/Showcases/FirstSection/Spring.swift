import UIKit

final class SpringViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 1,
                       options: [.repeat, .autoreverse]) {
            self.square.transform = .init(translationX: 0, y: 100)
        }
    }
}

struct SpringShowcase: ShowcaseRow {
    var title: String {
        "Spring"
    }
    
    var description: String {
        "Vamos aplicar efeitos de mola nas animações"
    }
    
    var destination: UIViewController {
        let vc = SpringViewController()
        vc.title = title
        return vc
    }
}
