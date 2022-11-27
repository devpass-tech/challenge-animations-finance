import UIKit

final class FadeInFadeOutViewController: BaseViewController {
    override func didTapActionButton() {
        /// Aplique as animações no objeto `square`
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
