import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(view)
        }
    }
}
