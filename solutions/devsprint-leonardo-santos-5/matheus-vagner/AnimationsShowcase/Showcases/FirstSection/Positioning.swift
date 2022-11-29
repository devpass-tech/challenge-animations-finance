import UIKit

final class PositioningViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.repeat, .autoreverse]) {
            self.square.transform = .init(translationX: 0, y: 200)
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
