import UIKit

final class SpringViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
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
