import UIKit

final class LottieBasicsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

struct LottieBasicsShowcase: ShowcaseRow {
    var title: String {
        "Conceitos básicos de Lottie"
    }
    
    var description: String {
        "Teoria e estudos da documentação da biblioteca Lottie"
    }
    
    var destination: UIViewController {
        let vc = LottieBasicsViewController()
        vc.title = title
        return vc
    }
}
