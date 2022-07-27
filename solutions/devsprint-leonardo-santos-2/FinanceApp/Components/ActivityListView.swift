//
//  ActivityListView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit
import Cartography

protocol ActivityListViewDelegate: AnyObject {
    func didSelectedActivity()
}

class ActivityListView: UIView {

    //MARK: - Properties
    weak var delegate: ActivityListViewDelegate?

    private let cellIdentifier = "ActivityCellIdentifier"
    static let cellSize = Constant.cellHeight

    //MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ActivityCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func commomInit() {
        configureViewCode()
        tableView.reloadData()
    }
    
    private func actionProviderHandler(_ menus: [UIMenuElement], at indexPath: IndexPath) -> UIMenu? {
        
        guard let cell = isActivityCell(at: indexPath) else { return .init() }
        let like = contextMenuButtonHandler(cell)
        
        let buttonChildrens: [UIAction] = [
            .default(title: Constant.openButtonTitle, icon: .link, action: openAction),
            .default(title: like.title, icon: like.icon) { self.likeAction($0, at: indexPath) }
        ]
        return UIMenu(
            title: Constant.contextMenuTitle, image: nil,
            identifier: nil, options: .displayInline,
            children: buttonChildrens
        )
    }
    
    private func openAction(_ action: UIAction) {
        delegate?.didSelectedActivity()
    }
    
    private func likeAction(_ action: UIAction, at indexPath: IndexPath) {
        guard let cell = isActivityCell(at: indexPath) else { return }
        cell.like()
    }
    
    private func isActivityCell(at indexPath: IndexPath) -> ActivityCellView? {
        return tableView.cellForRow(at: indexPath) as? ActivityCellView
    }
    
    private func contextMenuButtonHandler(
        _ activityCell: ActivityCellView
    ) -> (title: String, icon: SFSymbols) {
        
        let cellIsLiked = activityCell.acessoryViewIsSelected
        let likeTitle = cellIsLiked ? Constant.unlikeText : Constant.likeText
        let likeIcon = cellIsLiked ? Constant.heartIcon : Constant.heartFilledIcon
        return (likeTitle, likeIcon)
    }
}

//MARK: - ViewCodeProtocol
extension ActivityListView: ViewCodeProtocol {
    func configureHierarcy() {
        addSubview(tableView)
    }
    
    func configureConstraint() {
        NSLayoutConstraint.activate([

            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureStyle() {
        backgroundColor = .white
    }
}

//MARK: - UITableViewDataSource
extension ActivityListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.numberOfRowsInSection
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier, for: indexPath
        ) as? ActivityCellView else { return .init() }

        return cell
    }
}

//MARK: - UITableViewDelegate
extension ActivityListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectedActivity()
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint
    ) -> UIContextMenuConfiguration? {
        
        UIContextMenuConfiguration(
            identifier: nil, previewProvider: nil,
            actionProvider: { self.actionProviderHandler($0, at: indexPath) }
        )
    }
}

//MARK: - Constant
private extension ActivityListView {
    struct Constant {
        static let likeText = "Like"
        static let unlikeText = "Unlike"
        static let openButtonTitle = "Open"
        static let contextMenuTitle = "Activity"
        static let heartIcon = SFSymbols.heart
        static let heartFilledIcon = SFSymbols.heartFilled
        static let numberOfRowsInSection = 5
        static let cellHeight: CGFloat = 80
    }
}

extension UIAction {
    typealias ActionCompletionBlock = ((UIAction) -> Void)
    
    static func `default`(
        title: String, icon: SFSymbols,
        action: @escaping ActionCompletionBlock
    ) -> UIAction {
        
        return UIAction(
            title: title, image: .init(systemName: icon.rawValue),
            identifier: nil, discoverabilityTitle: nil, state: .on,
            handler: action
        )
    }
}

enum SFSymbols: String {
    case link
    case heart = "heart"
    case heartFilled = "heart.fill"
}
