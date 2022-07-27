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

final class ActivityListView: UIView {

    //MARK: - Properties
    weak var delegate: ActivityListViewDelegate?

    static let cellSize = Constant.cellHeight

    //MARK: - UI Components
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            ActivityCellView.self,
            forCellReuseIdentifier: ActivityCellView.identifier
        )
        return tableView
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }

    required init?(coder: NSCoder) {
        fatalError(Constant.coderInit)
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
            .default(
                title: Constant.openButtonTitle, icon: .link
            ) { self.openAction($0, at: indexPath) },
            .default(
                title: like.title, icon: like.icon
            ) { self.likeAction($0, at: indexPath) }
        ]
        return .init(
            title: Constant.contextMenuTitle, image: nil,
            identifier: nil, options: .displayInline,
            children: buttonChildrens
        )
    }
    
    private func openAction(_ action: UIAction, at indexPath: IndexPath) {
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
        constrain(self, tableView) {
            $1.edges == $0.safeAreaLayoutGuide.edges
        }
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ActivityCellView.identifier,
            for: indexPath
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
        
        return .init(
            identifier: nil,
            previewProvider: { [weak self] in
                guard let self = self else { return .init() }
                return self.previewProviderHandler(at: indexPath)
                
            }, actionProvider: { [weak self] action in
                guard let self = self else { return .init() }
                return self.actionProviderHandler(action, at: indexPath)
            }
        )
    }
    
    private func previewProviderHandler(at indexPath: IndexPath) -> UIViewController? {
        return ActivityDetailsViewController()
    }
}

//MARK: - Constant
private extension ActivityListView {
    struct Constant {
        static let likeText = "Like"
        static let unlikeText = "Unlike"
        static let openButtonTitle = "Open"
        static let contextMenuTitle = "Activity"
        static let coderInit = "init(coder:) has not been implemented"
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
    case heart
    case heartFilled = "heart.fill"
}


protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String { String(describing: self) }
}
