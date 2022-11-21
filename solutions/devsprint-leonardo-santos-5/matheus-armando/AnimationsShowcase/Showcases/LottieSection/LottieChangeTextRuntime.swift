import UIKit

final class LottieChangeTextViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

struct LottieChangeTextShowcase: ShowcaseRow {
    var title: String {
        "Alterar texto em runtime"
    }
    
    var description: String {
        "Exemplo de como alterar o texto de uma animação Lottie via código"
    }
    
    var destination: UIViewController {
        let vc = LottieChangeTextViewController()
        vc.title = title
        return vc
    }
}
