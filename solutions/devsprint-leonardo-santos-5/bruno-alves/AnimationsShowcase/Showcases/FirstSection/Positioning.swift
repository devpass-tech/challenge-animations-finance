import UIKit

final class PositioningViewController: BaseViewController {
    override func didTapActionButton() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse]) {
            self.square.transform = .init(translationX: 100, y: 100)
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
