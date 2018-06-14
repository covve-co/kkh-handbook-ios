//
//  CrisisContent.swift
//  kkh-handbook
//
//  Created by Sean Lim on 14/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class CrisisContent: GlobalController {
	
	var data: [[String: Any]]?
	
	private var cells: [CrisisContentCell] = []
	
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Build data
		data?.forEach({ data in
			let cells = cellsForData(data)
			cells.forEach {
				self.cells.append($0)
			}
		})
		
	}
	
	// Adapter for legacy content that maps to cells
	func cellsForData(_ data: [String: Any]) ->  [CrisisContentCell] {
		
		var res: [CrisisContentCell] = []
		let title = data.keys.first
		let payload = (data[title!] as! [String: Any])
		
		let type = payload["type"] as! String
		
		// Create title/header
		if type == "header"{
			res.append(headerCell(withTitle: title!))
		} else {
			res.append(titleCell(withTitle: title!))
		}
		
		// Create payload
		if type == "checkList" {
			(payload["content_list"] as! [String]).map{checkListCell(withContent: $0)}.forEach { cell in
				res.append(cell)
			}
		} else if type == "text" {
			res.append(textCell(withContent: payload["content"] as! String))
		}
		
		return res
		
	}
	
	
	
	
}

extension CrisisContent: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.cells.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return self.cells[indexPath.row]
	}
	
	
	
}

extension CrisisContent {
	func titleCell(withTitle: String) -> CrisisContentCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "title") as! CrisisContentCell
		cell.title.text = withTitle
		
		return cell
	}
	
	func headerCell(withTitle: String) -> CrisisContentCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! CrisisContentCell
		cell.title.text = withTitle
		
		return cell
	}
	
	func textCell(withContent: String) -> CrisisContentCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "text") as! CrisisContentCell
		cell.content.text = withContent
		
		return cell
	}
	
	func checkListCell(withContent: String) -> CrisisContentCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "chk") as! CrisisContentCell
		cell.content.text = withContent
		
		return cell
	}
	
	func ButtonCell(withTitle: String, event: @escaping () -> Void) -> CrisisContentCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "btn") as! CrisisContentCell
		cell.button.titleLabel!.text = withTitle
		cell.action = event
		
		return cell
	}
}


class CrisisContentCell: UITableViewCell {
	
	@IBOutlet var title: UILabel!
	@IBOutlet var content: UILabel!
	@IBOutlet var button: UIButton!
	
	var action: ( () -> Void? )?
	
	@IBAction func buttonPressed(_ sender: Any) {
		action!()
	}
	
	
}
