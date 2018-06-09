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
