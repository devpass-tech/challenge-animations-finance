import UIKit

extension UITableView {
    public func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    public func dequeue<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T
    }
}
