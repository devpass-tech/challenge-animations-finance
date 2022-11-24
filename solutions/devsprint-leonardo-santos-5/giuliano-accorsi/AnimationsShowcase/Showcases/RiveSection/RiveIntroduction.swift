import Cartography
import RiveRuntime
import UIKit

final class RiveIntroductionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

struct RiveIntroductionShowcase: ShowcaseRow {
    var title: String {
        "Introdução ao Rive"
    }
    
    var description: String {
        "Vamos ver como implementar e como alterar estados de uma animação Rive"
    }
    
    var destination: UIViewController {
        let vc = RiveIntroductionViewController()
        vc.title = title
        return vc
    }
}
