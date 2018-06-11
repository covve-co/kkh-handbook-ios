//
//  PDFManager.swift
//  kkh-handbookTests
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import XCTest
@testable import kkh_handbook

class PDFManager_Test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntegrity() {
		let instance = PDFManager()
		
		XCTAssertEqual(instance.numberOfChapters(), 17)
		XCTAssertEqual(instance.numberOfFiles(), 46)
		XCTAssertEqual(instance.numberOfFiles(), instance.getFiles()!.count)
		
		let testfile = instance.getFile(withId: 16)!
		let testfile2 = instance.getFile(withName: "ROTEM Algorithm")!
		let testfile3 = instance.getFile(withChapterIndex: 0, id: 0)
		
		XCTAssert(testfile3.name == "Training Programmes")
		
		XCTAssert(testfile.name == testfile2.name, "File names should be identical")
		
		let filesofPaediatricAnaesthesia = instance.getFiles(chapterIndex: 2)
		
		XCTAssertEqual(filesofPaediatricAnaesthesia?.count, 7)
		
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
