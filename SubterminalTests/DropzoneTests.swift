//
//  Dropzone.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 22/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import XCTest

class DropzoneTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	static func createDropzone() -> Dropzone {
		let dropzone = Dropzone()
		dropzone.name = "Irish Parachute Club"
		dropzone.country = "Ireland"
		dropzone.local = "Co. Louth"
		dropzone.latitude = 1
		dropzone.longtitude = 1
		dropzone.email = "info@dropzoneemail.com"
		dropzone.featured = 0
		dropzone.dropzone_description = "This is the description"
	
		_ = dropzone.save()
		
		return dropzone
	}
	
	func testSaveToDb() {
		
	}
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
