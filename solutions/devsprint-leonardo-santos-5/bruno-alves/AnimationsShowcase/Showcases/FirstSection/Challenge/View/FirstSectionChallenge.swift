import UIKit

final class FirstSectionChallengeViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let firstSectionView: FirstSectionChallengeView
    private let presenter: FirstSectionChallengePresenter
    private var isOpen = false
    
    // MARK: - Init
    
    init(firstSectionView: FirstSectionChallengeView,
         presenter: FirstSectionChallengePresenter) {
        self.firstSectionView = firstSectionView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = firstSectionView
        firstSectionView.delegate = self
    }
}

// MARK: - Extension

extension FirstSectionChallengeViewController: FirstSectionChallengeViewDelegate {
    func didCallAnimation() {
        if isOpen {
            isOpen = false
            let imageName = "backCard.png"
            let image = UIImage(named: imageName)
            firstSectionView.cardImageView.image = image
            UIView.transition(with: firstSectionView.cardImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
        } else {
            isOpen = true
            let imageName = "frontCard.png"
            let image = UIImage(named: imageName)
            firstSectionView.cardImageView.image = image
            
            UIView.transition(with: firstSectionView.cardImageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil)
        }
    }
}

// MARK: - ShowcaseRow

struct FirstSectionChallengeShowcase: ShowcaseRow {
    var title: String {
        "UIView.animate Challenge 🏆"
    }
    
    var description: String {
        "Utilize sua criatividade e faça uma animação que pode ser usada em produção"
    }
    
    var destination: UIViewController {
        let firstSection = FirstSectionChallengeView()
        let presenter = FirstSectionChallengePresenter()
        let vc = FirstSectionChallengeViewController(firstSectionView: firstSection,
                                                     presenter: presenter)
        vc.title = title
        return vc
    }
}
