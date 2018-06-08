//
//  File.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit
import PDFReader

struct File {
	let name: String
	let id: Int
	let chapterId: Int
	let path: URL
	
	// Display PDFViewer
	func buildController() -> UIViewController  {
		return PDFViewController.createNew(with: PDFAdapter.displayFile(name))
	}
}

class PDFAdapter {
	static func displayFile (_ name: String) -> PDFDocument {
		let documentFileURL = Bundle.main.url(forResource: name, withExtension: "pdf")!
		return PDFDocument(url: documentFileURL)!
	}
}
