import UIKit

final class BezierCurvesViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
    }
}

struct BezierShowcase: ShowcaseRow {
    var title: String {
        "Bezier Curves"
    }
    
    var description: String {
        "Exemplos de implementação das Curvas Cubicas de Bézier"
    }
    
    var destination: UIViewController {
        let vc = BezierCurvesViewController()
        vc.title = title
        return vc
    }
}
