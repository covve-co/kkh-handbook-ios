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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		let instance = PDFManager()
		
		XCTAssertEqual(instance.numberOfChapters(), 17)
		XCTAssertEqual(instance.numberOfFiles(), 46)
		
		let testfile = instance.getFile(withId: 16)!
		let testfile2 = instance.getFile(withName: "ROTEM Algorithm")!
		
		XCTAssert(testfile.name == testfile2.name, "File getters broken")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
