import Foundation
import UIKit

struct ShowcaseSection {
    var title: String?
    var subtitle: String?
    var rows: [ShowcaseRow]
    
    init(
        title: String? = nil,
        subtitle: String? = nil,
        rows: [ShowcaseRow]
    ) {
        self.title = title
        self.subtitle = subtitle
        self.rows = rows
    }
}

protocol ShowcaseRow {
    var title: String { get }
    var description: String { get }
    var destination: UIViewController { get }
}
