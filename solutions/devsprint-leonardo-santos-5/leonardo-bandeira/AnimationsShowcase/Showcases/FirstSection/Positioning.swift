import UIKit

final class PositioningViewController: BaseViewController {
    // MARK: - Property(ies).
    private var pointPosition: Int = 0
    private var points: [CGPoint] = [.init(x: 120, y: 0),
                                     .init(x: 0, y: 0),
                                     .init(x: 0, y: 120),
                                     .init(x: 0, y: 0),
                                     .init(x: -120, y: 0),
                                     .init(x: 0, y: 0),
                                     .init(x: 0, y: -120),
                                     .init(x: 0, y: 0)]
    private var timer: Timer?
    
    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc
    override func didTapActionButton() {
        guard let _ = timer else {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(didTapActionButton),
                                              userInfo: nil,
                                              repeats: true)
            return
        }

        if pointPosition != points.endIndex {
            animate(object: square, withTranslation: points[pointPosition])
            pointPosition += 1
        } else {
            pointPosition = 0
        }
    }
    
    // MARK: - Method(s).
    private func animate(object: UIView, withTranslation: CGPoint) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut]) {
            object.transform = .init(translationX: withTranslation.x, y: withTranslation.y)
        }
    }
}

struct PositioningShowcase: ShowcaseRow {
    var title: String {
        "Posição"
    }
    
    var description: String {
        "Vamos alterar o x e y da animação para faze-la ir do ponto A até o ponto B"
    }
    
    var destination: UIViewController {
        let vc = PositioningViewController()
        vc.title = title
        return vc
    }
}
