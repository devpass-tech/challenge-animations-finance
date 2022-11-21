import UIKit

final class LottieChallengeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

struct LottieChallengeShowcase: ShowcaseRow {
    var title: String {
        "Lottie Challenge 🏆"
    }
    
    var description: String {
        "Coloque os conhecimentos em prática nesse desafio de Lottie!"
    }
    
    var destination: UIViewController {
        let vc = LottieChallengeViewController()
        vc.title = title
        return vc
    }
}
