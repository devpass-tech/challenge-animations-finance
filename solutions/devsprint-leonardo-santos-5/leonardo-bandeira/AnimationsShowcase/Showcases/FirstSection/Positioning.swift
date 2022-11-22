import UIKit

final class PositioningViewController: BaseViewController {
    override func didTapActionButton() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .curveEaseInOut, .repeat]) {
            self.square.transform = .init(translationX: 120, y: 60)
        }
    }
}

struct PositioningShowcase: ShowcaseRow {
    var title: String {
        "Posição"
    }
    
    var description: String {
        "Vamos alterar o x e y da animação para faze-la ir do ponto A até o ponto B"
    }
    
    var destination: UIViewController {
        let vc = PositioningViewController()
        vc.title = title
        return vc
    }
}
