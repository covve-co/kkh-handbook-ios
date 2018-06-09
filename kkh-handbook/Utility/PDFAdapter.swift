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
	static func displayFile (_ path: URL) -> PDFDocument {
		let documentFileURL = Bundle.main.url(forResource: path.absoluteString, withExtension: nil)
		return PDFDocument(url: documentFileURL!)!
	}
	
	static func buildView (_ path: URL, _ name: String) -> UIViewController {
		
		let pdfController = PDFViewController.createNew(with:  PDFAdapter.displayFile(path), title: name, actionButtonImage: nil, actionStyle: .activitySheet, backButton: nil, isThumbnailsEnabled: false, startPageIndex: 0)
		pdfController.scrollDirection = .vertical
		pdfController.backgroundColor = .white
		return pdfController
	}
}
