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
	
	@IBOutlet var scrollView: UIScrollView!
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
	
	override func transitionSetup() {
		self.tableView.hero.modifiers = [ .opacity(0) , .translate(y:300)]
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

extension CrisisContent: UIScrollViewDelegate{
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if self.scrollView.contentOffset.y < -210 {
			self.dismiss(animated: true, completion: nil)
		}
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
