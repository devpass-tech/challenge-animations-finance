import Cartography
import RiveRuntime
import UIKit

final class RiveChallengeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

struct RiveChallengeShowcase: ShowcaseRow {
    var title: String {
        "Rive Challenge 🏆"
    }

    var description: String {
        "Aplique os seus conhecimentos de Rive"
    }

    var destination: UIViewController {
        let vc = RiveChallengeViewController()
        vc.title = title
        return vc
    }
}
