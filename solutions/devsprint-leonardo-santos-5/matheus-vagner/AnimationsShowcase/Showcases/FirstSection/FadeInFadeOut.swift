import UIKit

final class FadeInFadeOutViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
        UIView.animate(withDuration: 1,
                       delay: 0.5,
                       options: [.repeat, .autoreverse, .curveEaseInOut]) {
        self.square.alpha = 0.0
    }
    }
}

struct FadeInFadeOutShowcase: ShowcaseRow {
    var title: String {
        "Fade-in / Fade-out"
    }
    
    var description: String {
        "Implementação de uma animação de entrada e saída"
    }
    
    var destination: UIViewController {
        let vc = FadeInFadeOutViewController()
        vc.title = title
        return vc
    }
}
