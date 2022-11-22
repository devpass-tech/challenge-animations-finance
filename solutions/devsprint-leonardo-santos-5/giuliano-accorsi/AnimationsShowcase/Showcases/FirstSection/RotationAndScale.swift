import UIKit

final class RotationAndScaleViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
    }
}

struct RotationAndScaleShowcase: ShowcaseRow {
    var title: String {
        "Rotação e Escala"
    }
    
    var description: String {
        "Vamos aplicar os conhecimentos de transform para girar e aumentar o tamanho do quadrado"
    }
    
    var destination: UIViewController {
        let vc = RotationAndScaleViewController()
        vc.title = title
        return vc
    }
}
