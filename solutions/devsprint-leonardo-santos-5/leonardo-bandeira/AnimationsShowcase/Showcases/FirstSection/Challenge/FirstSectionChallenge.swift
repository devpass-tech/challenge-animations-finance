import UIKit

final class FirstSectionChallengeViewController: UIViewController {
    // MARK: - Component(s).
    private let snkrsView: SnkrsView = {
        let view = SnkrsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let airJordanView: AirJordanView = {
        let view = AirJordanView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - ViewCodable.
extension FirstSectionChallengeViewController: ViewCodable {
    func setupSubviews() {
        [snkrsView, airJordanView].forEach { view.addSubview($0) }
    }
    
    func setupConstraints() {
        snkrsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        snkrsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        snkrsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        snkrsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        airJordanView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        airJordanView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        airJordanView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        airJordanView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupExtraConfiguration() {
        title = nil
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
