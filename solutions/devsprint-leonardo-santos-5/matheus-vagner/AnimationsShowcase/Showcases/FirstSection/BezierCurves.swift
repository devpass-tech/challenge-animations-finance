import UIKit

final class BezierCurvesViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
        let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0, 1, 1)
        CATransaction.setAnimationTimingFunction(timeFunc)
        UIView.transition(with: square,
                          duration: 0.5) {
                self.actionButton.setTitle("", for: .normal)
                self.square.transform = .init(translationX: 100, y: 300)
        } completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0) {
                self.square.transform = .init(translationX: 150, y: 100)
            } completion: { _ in
                UIView.animate(withDuration: 0.4, delay: 0) {
                    self.square.transform = .init(translationX: 0, y: 0)
                } completion: { _ in
                    self.actionButton.setTitle("Animar", for: .normal)
                }
            }
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
