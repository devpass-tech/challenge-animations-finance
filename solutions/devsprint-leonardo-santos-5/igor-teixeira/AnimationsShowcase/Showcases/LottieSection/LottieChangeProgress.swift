import UIKit

final class LottieChangeProgressViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

struct LottieChangeProgressShowcase: ShowcaseRow {
    var title: String {
        "Alterar progresso da animação"
    }
    
    var description: String {
       ""
    }
    
    var destination: UIViewController {
        let vc = LottieChangeProgressViewController()
        vc.title = title
        return vc
    }
}
