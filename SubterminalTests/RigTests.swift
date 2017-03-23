//
//  RigTests.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 22/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import XCTest

class RigTests: XCTestCase {
	
	static func createRig() -> Rig {
		let rig = Rig()
		
		rig.container_model = "Container Model"
		rig.container_manufacturer = "Container Manufacturer"
		rig.container_serial = "Container Serial"
		rig.container_date_in_use = DateHelper.stringToDate(string: "2009-09-01")

		rig.main_model = "Main Model"
		rig.main_manufacturer = "Main Manufacturer"
		rig.main_serial = "Main Serial"
		rig.main_date_in_use = DateHelper.stringToDate(string: "2008-09-01")

		rig.reserve_model = "Reserve Model"
		rig.reserve_manufacturer = "Reserve Manufacturer"
		rig.reserve_serial = "Reserve Serial"
		rig.reserve_date_in_use = DateHelper.stringToDate(string: "2007-09-01")

		rig.aad_model = "Container Model"
		rig.aad_manufacturer = "Container Manufacturer"
		rig.aad_serial = "Container Serial"
		rig.aad_date_in_use = DateHelper.stringToDate(string: "2006-09-01")

		_ = rig.save()
		
		return rig
	}
	
	func testSaveToDb() {
		let rig = RigTests.createRig()
		XCTAssertNotNil(rig.id)
		
		//Check retrieved object is the same
		let dbRig = Rig.object(withPrimaryKeyValue: rig.id) as? Rig
		XCTAssertTrue(rig.isEqual(dbRig))
		
		//Make sure if we change something it triggers isEqual false
		dbRig?.container_serial = "something else"
		XCTAssertFalse(rig.isEqual(dbRig))
	}
	
	func testDeleteRigUpdatedSkydives() {
		
	}
}
