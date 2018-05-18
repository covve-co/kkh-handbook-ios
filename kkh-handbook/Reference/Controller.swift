//
//  Reference.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

final class ReferenceView: GlobalController {
	
	var model = ReferenceViewModel()
	override func viewDidLoad() {
		
	}
}

// Table view
extension ReferenceView: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.manager.getFiles(chapterIndex: section)!.count
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = ReferenceSectionHeader.instanceFromNib()
		headerView.label?.text = model.manager.getChapter(forId: section)
		return headerView
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		// TODO search condition
		return model.manager.numberOfChapters() - 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReferenceViewCell
		cell.label.text = model.manager.getFiles(chapterIndex: indexPath.section)![indexPath.row].name
		return cell
	}
}
