//
//  Dropzone.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 22/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import XCTest

class DropzoneTests: XCTestCase {
	
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
	
	static func createAircraft() -> Aircraft {
		let aircraft = Aircraft()
		aircraft.name = "Test Aircraft"
		
		_ = aircraft.save()
		
		return aircraft
	}
	
	func testSaveToDb() {
		let dropzone = DropzoneTests.createDropzone()
	
		XCTAssertNotNil(dropzone.id)
	}
}
