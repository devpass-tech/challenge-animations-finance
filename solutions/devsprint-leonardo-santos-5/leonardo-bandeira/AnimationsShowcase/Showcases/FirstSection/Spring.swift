import UIKit

final class SpringViewController: BaseViewController {
    override func didTapActionButton() {
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 0.65,
                       initialSpringVelocity: 12,
                       options: .curveEaseIn) {
            self.square.transform = .init(translationX: 0, y: 160)
        } completion: { _ in
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 6,
                           options: .curveEaseOut) {
                self.square.transform = .init(translationX: 0, y: 0)
            }
        }
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
