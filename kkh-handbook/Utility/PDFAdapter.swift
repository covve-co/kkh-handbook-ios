//
//  PDFAdapter.swift
//  kkh-handbook
//
//  Created by Sean Lim on 9/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit
import PDFReader

class PDFAdapter {
	static func displayFile (_ name: String) -> PDFDocument {
		let documentFileURL = Bundle.main.url(forResource: name, withExtension: "pdf")!
		return PDFDocument(url: documentFileURL)!
	}
	
	static func buildView (_ name: String) -> UIViewController {
		return PDFViewController.createNew(with: PDFAdapter.displayFile(name))
	}
}
