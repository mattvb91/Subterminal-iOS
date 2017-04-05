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
	
	func testSaveAircraftToDb() {
		let aircraft = DropzoneTests.createAircraft()
		XCTAssertNotNil(aircraft.id)
		
		let dbAircraft = Aircraft.object(withPrimaryKeyValue: aircraft.id)
		XCTAssertTrue(aircraft.isEqual(dbAircraft))
	}
	
	func testSaveToDb() {
		let dropzone = DropzoneTests.createDropzone()
		XCTAssertNotNil(dropzone.id)
		
		let dbDropzone = Dropzone.object(withPrimaryKeyValue: dropzone.id)
		XCTAssertTrue(dropzone.isEqual(dbDropzone))
		
		dropzone.country = "different"
		XCTAssertFalse(dropzone.isEqual(dbDropzone))
	}
}
