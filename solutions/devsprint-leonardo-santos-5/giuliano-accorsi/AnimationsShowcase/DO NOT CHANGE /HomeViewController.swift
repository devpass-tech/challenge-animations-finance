import UIKit

final class HomeViewController: UITableViewController {
    // MARK: - Properties
    
    let components = Showcase().components
    
    // MARK: Object lifecycle
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        title = "Animações"
        
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(HeaderCell.self)
        tableView.register(HomeCell.self)
    }
}

// MARK: - Delegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let component = components[indexPath.section].rows[indexPath.row]
        navigationController?.pushViewController(component.destination, animated: true)
    }
}

// MARK: - DataSource
extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        components.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        components[section].rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = components[indexPath.section].rows[indexPath.row]
        if indexPath.section == 0 {
            let cell = tableView.dequeue(type: HeaderCell.self, for: indexPath)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeue(type: HomeCell.self, for: indexPath)
            cell?.render(title: component.title, subtitle: component.description)
            return cell ?? UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let title = components[section].title,
            let subtitle = components[section].subtitle
        else { return nil }
        
        let view = HomeSectionView()
        view.configure(with: title, and: subtitle)
        return view
    }
}
