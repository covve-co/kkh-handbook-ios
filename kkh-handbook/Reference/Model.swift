//
//  Model.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

struct ReferenceViewModel {
	let manager = PDFManager()
	
	// Content that is displayed on tableview
	var content: [File] = []
	
	init() {
		content = manager.getFiles()!
	}
	
	mutating func search(query: String) {
		content = manager.queryFiles(query)!
	}
	
}
