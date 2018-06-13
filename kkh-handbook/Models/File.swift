//
//  File.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

struct File {
	let name: String
	let id: Int
	let chapterId: Int
	let path: URL
	var isBookmarked: Bool {
		get {
			return UserDefaults.standard.bool(forKey: String(id))
		}
	}
	
	// Display PDFViewer
	func buildController() -> UIViewController  {
		return PDFAdapter.buildView(self.path, name)
	}
	
}
