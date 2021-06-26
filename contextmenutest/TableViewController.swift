//
//  TableViewController.swift
//  contextmenutest
//
//  Created by Hristo Staykov on 26/06/2021.
//

import UIKit

class TableViewController: UITableViewController {
    enum Row: Hashable { case text(String) }
    enum Section: Hashable { case main }
    typealias DataSource = UITableViewDiffableDataSource<Section, Row>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

    lazy var dataSource: DataSource = {
        DataSource(tableView: self.tableView) { _, _, row in
            guard case let .text(text) = row else { return nil }
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = text
            cell.contentConfiguration = content
            return cell
        }
    }()

    init() {
        super.init(style: .plain)
        
        self.title = "Table View"

        self.tableView.dragInteractionEnabled = true
        self.tableView.dragDelegate = self
        self.tableView.dropDelegate = self
            
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems((0...10).map { .text("Item \($0)") })
        
        dataSource.apply(snapshot)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let action = UIAction(title: "Custom action") { action in
                // Put button handler here
            }
            return UIMenu(title: "Menu", children: [action])
        }
        return configuration
    }
}


extension TableViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        for item in coordinator.items {
            if let source = item.sourceIndexPath,
               let destination = coordinator.destinationIndexPath {
               
            }
            
        }
    }


    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath:
IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        return [ dragItem ]
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        print("Move to \(destinationIndexPath?.row ?? -1)")
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
