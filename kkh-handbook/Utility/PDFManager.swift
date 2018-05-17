//
//  PDFManager.swift
//  Handbook
//
//  Created by Ravern on 9/6/16.
//  Copyright © 2016 SST Inc. All rights reserved.
//

import UIKit

class PDFManager: NSObject {
	
	private var files: [Int: File] = [:]
	private var chapters: [String] = []
	
	override init() {
		super.init()
		let bundleRoot = Bundle.main
		let fileManager = FileManager.default
		var contents: [String]!
		
		// Read files
		do { contents = try fileManager.contentsOfDirectory(atPath: bundleRoot.bundlePath) }
		catch {
			print("Read root bundle failed")
		}
		
		// Read Chapters
		if let url = bundleRoot.url(forResource: "Chapters", withExtension: "plist") {
			let readchapters = NSArray(contentsOf: url) as? [String]
			readchapters?.forEach{chapters.append($0)}
		}
		
		// Map files
		contents.filter{ $0.hasSuffix(".pdf")}.forEach {
			let a = $0.split(separator: "-")
			files[Int(a[1])! - 1] = File(
				name: a[2]
					.replacingOccurrences(of: "_", with: " ")
					.replacingOccurrences(of: ".pdf", with: ""),
				id: Int(a[1])!,
				chapter:  chapters[Int(a[0])! - 1],
				path: URL(string: $0)!
				)
		}
		
	}
	
	func getFile(withId: Int) -> File? {
		return files[withId-1]
	}
	
	func getFile(withName: String) -> File? {
		var res: File?
		for file in files.values {
			if file.name == withName {
				res = file
				break
			}
		}
		return res
	}
	
	func numberOfFiles() -> Int {
		return files.count
	}
	
	func numberOfChapters() -> Int {
		return chapters.count
	}
	
}


