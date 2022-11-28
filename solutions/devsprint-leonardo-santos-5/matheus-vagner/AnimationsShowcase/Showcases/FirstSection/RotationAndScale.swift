import UIKit

final class RotationAndScaleViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [.repeat, .autoreverse]) {
            self.square.transform = .init(rotationAngle: CGFloat.pi)
            self.square.transform = .init(scaleX: 2, y: 2)
        }
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
