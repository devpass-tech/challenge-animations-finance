import UIKit

final class BezierCurvesViewController: BaseViewController {
    override func didTapActionButton() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .curveEaseInOut, .repeat]) {
            self.square.transform = .init(rotationAngle: CGFloat(180 * CGFloat.pi/180))
            self.square.transform = .init(scaleX: 2, y: 2)
        }
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
