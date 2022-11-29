import UIKit

final class FirstSectionChallengeViewController: UIViewController {
    let step:Float = 10
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.tintColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Qual o tamanho do diâmetro do pote?"
        label.isHidden = true
        return label
    }()
    
    private lazy var baseImageView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var plantImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "smallPlant")
        return imageView
    }()
    
    private lazy var sizePlantSlider: UISlider = {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 10
        slider.maximumValue = 40
        slider.isContinuous = true
        slider.tintColor = UIColor.green
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        slider.isHidden = true
        return slider
    }()
    
    private lazy var plantSizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 48)
        label.tintColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "6.0"
        return label
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.tintColor = .darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "cm"
        return label
    }()
    
    private lazy var sizeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [plantSizeLabel, sizeLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.isHidden = true
        return stack
    }()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialAnimation()
    }
}

extension FirstSectionChallengeViewController {
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        let plantSize = Double(sizePlantSlider.value)
        let sizeString = String(format: "%.1f", plantSize)
        plantSizeLabel.text = "\(sizeString)"
        animatePlantImage(sizePlant: plantSize)
    }
    
    private func animatePlantImage(sizePlant: Double) {
        let isSmallPlant = (10.0..<20.0).contains(sizePlant)
        let isMediumPlant = (20.0..<30.0).contains(sizePlant)
        
        let small = ((sizePlant - 9) / 10) + 1
        let medium = ((sizePlant - 19) / 10) + 2
        let big = ((sizePlant - 29) / 10) + 3
        
        UIView.animate(withDuration: 0.5, delay: 0) {
            if isSmallPlant {
                self.plantImageView.image = UIImage(named: "smallPlant")
                self.plantImageView.transform = .init(scaleX: small, y: small)
            } else if isMediumPlant {
                self.plantImageView.image = UIImage(named: "mediumPlant")
                self.plantImageView.transform = .init(scaleX: medium, y: medium)
            } else {
                self.plantImageView.image = UIImage(named: "bigPlant")
                self.plantImageView.transform = .init(scaleX: big, y: big)
            }
        }
    }
    
    private func initialAnimation() {
        UIView.transition(with: self.plantImageView, duration: 1) {
            self.plantImageView.transform = .init(scaleX: 8, y: 8)
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0) {
                self.plantImageView.transform = .init(scaleX: 1, y: 1)
            } completion: { _ in
                self.sizeStackView.isHidden = false
                self.sizePlantSlider.isHidden = false
                self.questionLabel.isHidden = false
                self.baseImageView.clipsToBounds = true
                self.plantImageView.clipsToBounds = true
            }
        }
    }
}

// MARK: - ViewConfiguration
extension FirstSectionChallengeViewController: ViewCodable {
    func setupSubviews() {
        baseImageView.addSubview(plantImageView)
        view.addSubviews([questionLabel,
                          baseImageView,
                          sizePlantSlider,
                          sizeStackView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            baseImageView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            baseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseImageView.heightAnchor.constraint(equalToConstant: 270),
            baseImageView.widthAnchor.constraint(equalToConstant: 270),
            
            plantImageView.centerYAnchor.constraint(equalTo: baseImageView.centerYAnchor),
            plantImageView.centerXAnchor.constraint(equalTo: baseImageView.centerXAnchor),
            plantImageView.heightAnchor.constraint(equalToConstant: 80),
            plantImageView.widthAnchor.constraint(equalToConstant: 80),
            
            sizeStackView.topAnchor.constraint(equalTo: baseImageView.bottomAnchor, constant: 24),
            sizeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sizePlantSlider.topAnchor.constraint(equalTo: sizeStackView.bottomAnchor, constant: 24),
            sizePlantSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sizePlantSlider.widthAnchor.constraint(equalToConstant: 300),
            sizePlantSlider.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setupExtraConfiguration() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Challenge 🏆"
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
        let vc = FirstSectionChallengeViewController()
        vc.title = title
        return vc
    }
}
