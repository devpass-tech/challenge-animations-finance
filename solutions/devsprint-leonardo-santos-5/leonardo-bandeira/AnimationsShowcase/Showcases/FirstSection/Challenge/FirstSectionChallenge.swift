import UIKit

final class FirstSectionChallengeViewController: UIViewController {
    // MARK: - Component(s).
    
    
    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - ViewCodable.
extension FirstSectionChallengeViewController: ViewCodable {
    func setupSubviews() {}
    
    func setupConstraints() {}
    
    func setupExtraConfiguration() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - ShowcaseRow.
struct FirstSectionChallengeShowcase: ShowcaseRow {
    var title: String {
        "UIView.animate Challenge 🏆"
    }
    
    var description: String {
        "Utilize sua criatividade e faça uma animação que pode ser usada em produção"
    }
    
    var destination: UIViewController {
        let vc = FirstSectionChallengeViewController()
        vc.title = title
        return vc
    }
}
