//
//  PDFManager.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import UIKit

class PDFManager: NSObject {
	
	private var files: [Int: [File]] = [:]
	private var chapters: [String] = []
	
	override init() {
		super.init()
		let bundleRoot = Bundle.main
		let fileManager = FileManager.default
		var contents: [String]!
		
		// Read files
		do {
			contents = try fileManager
				.contentsOfDirectory(atPath: bundleRoot.bundlePath) }
		catch {
			print("Read root bundle failed")
		}
		
		// Read Chapters
		if let url = bundleRoot.url(forResource: "Chapters",
									withExtension: "plist") {
			let readchapters = NSArray(contentsOf: url) as? [String]
			readchapters?.forEach{chapters.append($0)}
			// Clean up dirty chapter names
			chapters = chapters.map{$0.replacingOccurrences(of: "\n", with: "")}
			}
		
		// Map to Files
		contents.filter{ $0.hasSuffix(".pdf")}.forEach {
			let a = $0.split(separator: "-")
			if files[Int(a[0])! - 1] == nil  {
				files[Int(a[0])! - 1] = []
			}
			files[Int(a[0])! - 1]!.append(
				File(
					name: a[2]
						.replacingOccurrences(of: "_", with: " ")
						.replacingOccurrences(of: ".pdf", with: ""),
					id: Int(a[1])!,
					chapterId:  Int(a[0])! - 1,
					path: URL(string: $0)!
				)
			)
		}
		
	}
	
	func getFiles() -> [File]? {
		return files.flatMap{$1}
	}
	
	func getFiles(chapterIndex: Int) -> [File]? {
		return files[chapterIndex]
	}
	
	func getFile(withId: Int) -> File? {
		return files.flatMap{$1}[withId-1]
	}
	
	func getFile(withName: String) -> File? {
		var res: File?
		for file in files.flatMap({$1}) {
			if file.name == withName {
				res = file
				break
			}
		}
		return res
	}
	
	func getFile(withChapterIndex: Int, id: Int) -> File {
		return files[withChapterIndex]![id]
	}
	
	func queryFiles(_ queryString: String) -> [File]? {
		return files
			.flatMap{$1}
			.filter{$0.name.contains(queryString)}
	}
	
	func getChapter(forId: Int) -> String {
		return chapters[forId]
	}
	
	func numberOfFiles() -> Int {
		return files.flatMap{$1}.count
	}
	
	func numberOfChapters() -> Int {
		return chapters.count
	}
	
}


