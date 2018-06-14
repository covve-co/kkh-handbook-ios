//
//  CrisisComponentFactory.swift
//  kkh-handbook
//
//  Created by Sean Lim on 14/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

// Component Factory
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
