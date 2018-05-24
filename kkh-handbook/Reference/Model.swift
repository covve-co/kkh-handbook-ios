//
//  Model.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//
import UIKit

struct ReferenceViewModel {
	let manager = PDFManager()
	
	// Store view instance
	var viewInstance: ReferenceView?
	
	// Proxy for content
	var content: [File] = []
	
	// Store search state
	var searching: Bool = false
	
	init() {
		content = manager.getFiles()!
	}
	
	// Bind instance of reference view
	mutating func bind(_ view: ReferenceView) {
		viewInstance = view
		updateView()
	}
	
	mutating func build() {
		content = manager.getFiles()!
		updateView()
	}
	
	mutating func search(query: String?) {
		if let q = query {
			content = manager.queryFiles(q)!
		}
		else {
			content = manager.getFiles()!
		}
		updateView()
	}
	
	// Update view
	func updateView(){
		viewInstance!.rows = content.count
		viewInstance!.sections = searching ? 1:manager.numberOfChapters()
		reloadTable()
	}
	
	// Reload table
	func reloadTable() {
		viewInstance!.tableView.reloadData()
	}
	
}
