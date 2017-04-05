//
//  SkydiveTests.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 23/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import XCTest

class SkydiveTests: XCTestCase {
	
	static func createSkydive() -> Skydive {
		let skydive = Skydive()
		skydive.dropzone_id = DropzoneTests.createDropzone().id
		skydive.date = Date()
		skydive.delay = 5
		skydive.deploy_altidude = 3000
		skydive.exit_altitude = 13000
		skydive.height_unit = NSNumber(value: Subterminal.HEIGHT_UNIT_IMPERIAL)
		skydive.aircraft_id = DropzoneTests.createAircraft().id
		skydive.skydive_description = "This is the skydive description"
		
		_ = skydive.save()
		
		debugPrint(skydive)
		
		return skydive
	}
	
	func testSaveToDb() {
		let skydive = SkydiveTests.createSkydive()
		XCTAssertNotNil(skydive.id)
		
		XCTAssertNotNil(skydive.dropzone_id)
		XCTAssertNotNil(skydive.delay)
		
		let dbSkydive = Skydive.init(primaryKeyValue: skydive.id)!
		XCTAssertTrue(skydive.isEqual(dbSkydive))
		
		skydive.skydive_description = "Another description"
		
	}
}
