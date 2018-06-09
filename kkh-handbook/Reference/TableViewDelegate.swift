//
//  Cell.swift
//  kkh-handbook
//
//  Created by Sean Lim on 18/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

// Table view
extension ReferenceView: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView,
				   didSelectRowAt indexPath: IndexPath) {
		let fileView = content[indexPath.section].1[indexPath.row]
													.buildController()
		self.navigationController?.pushViewController(fileView, animated: true)
		self.navigationController?.navigationBar.prefersLargeTitles = false
	}
	
	func tableView(_ tableView: UITableView,
				   numberOfRowsInSection section: Int) -> Int {
		return content[section].1.count
	}
	
	func tableView(_ tableView: UITableView,
				   viewForHeaderInSection section: Int) -> UIView? {
		let headerView = ReferenceSectionHeader.instanceFromNib()
		headerView.label?.text = content[section].0
		return headerView
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		// TODO search condition
		return content.count
	}
	
	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView
			.dequeueReusableCell(withIdentifier: "cell") as! ReferenceViewCell
		cell.label.text = content[indexPath.section].1[indexPath.row].name
		return cell
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let file = content[indexPath.section].1[indexPath.row]
		let action = UIContextualAction(style: .normal, title: nil) { _, _, _ in
			print("Will bookmark \(file.name)")
			tableView.setEditing(false, animated: true)
		}
		action.image = #imageLiteral(resourceName: "bookmark") // RIP light theme users
		action.backgroundColor = UIColor(red:1.00, green:0.84, blue:0.00, alpha:1.0)
		let swipeConfig = UISwipeActionsConfiguration(actions: [action])
		return swipeConfig
	}
	
}

class ReferenceViewCell: UITableViewCell {
	@IBOutlet var label: UILabel!

}

class ReferenceSectionHeader: UIView {
	@IBOutlet var label: UILabel!
	class func instanceFromNib() -> ReferenceSectionHeader {
		return UINib(nibName: "Section header", bundle: nil)
			.instantiate(withOwner: nil,
						 options: nil)[0] as! ReferenceSectionHeader
	}
}
