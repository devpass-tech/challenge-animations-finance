import UIKit

final class LottieChangeColorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

struct LottieChangeColorShowcase: ShowcaseRow {
    var title: String {
        "Alterar cor em runtime"
    }
    
    var description: String {
        "Exemplo de como alterar a cor de uma animação Lottie via código"
    }
    
    var destination: UIViewController {
        let vc = LottieChangeColorViewController()
        vc.title = title
        return vc
    }
}
