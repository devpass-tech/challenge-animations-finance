import UIKit

final class HeaderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

struct HeaderShowcase: ShowcaseRow {
    var title: String {
        ""
    }
    
    var description: String { "" }
    
    var destination: UIViewController {
        let vc = UIViewController()
        vc.title = title
        return vc
    }
}
