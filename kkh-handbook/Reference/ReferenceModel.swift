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
	
	// Files
	private var files: [File] = []
	
	// Content
	var content: [Chapter] = []
	
	// Store search state
	var searching: Bool = false
	
	init() {
		build()
	}
	
	// Bind instance of reference view
	mutating func bind(_ view: ReferenceView) {
		viewInstance = view
		updateView()
	}
	
	mutating func build() {
		// Setup files
		files = manager.getFiles()!
		// Setup content			
		content = [Int](0..<manager.numberOfChapters())
			.map{makeChapter($0)}
	}
	
	// Updates the bound instance with model content
	func updateView(_ content: [Chapter]? = nil) {
		viewInstance!.content = content ?? self.content
		reloadTable()
	}
	
	// Reloads table in bound instance
	func reloadTable() {
		viewInstance!.tableView.reloadData()
	}
	
}

extension ReferenceViewModel {
	// Chapter factory
	func makeChapter(_ id: Int) -> Chapter {
		return (manager.getChapter(forId: id), manager.getFiles(chapterIndex: id)!)
	}
	
	// Searching function
	mutating func search(query: String?) {
		if query != nil {
			updateView(viewInstance?.content
				.map {($0.0, $0.1.filter {$0.name.lowercased().contains(query!.lowercased())})}
				.filter{!$0.1.isEmpty}
			)
		} else {
			updateView()
		}
	}
}
