import UIKit

final class RotationAndScaleViewController: BaseViewController {
    override func didTapActionButton() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .curveEaseInOut, .repeat]) {
            self.square.transform = .init(rotationAngle: CGFloat(180 * CGFloat.pi/180))
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
