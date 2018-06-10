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
	
	// Display PDFViewer
	func buildController() -> UIViewController  {
		return PDFAdapter.buildView(self.path, name)
	}
	
	func isBookmarked() -> Bool {
		return UserDefaults.standard.bool(forKey: String(id))
	}
	
}
