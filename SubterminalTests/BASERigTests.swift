//
//  BASERigTests.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 26/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import XCTest

class BASERigTests: XCTestCase {

	static func createBaseRig() -> BASERig {
		let rig = BASERig()
		rig.container_manufacturer = "Container Manufacturer"
		rig.container_type = "container type"
		rig.container_serial = "Container serial"
		rig.container_date_in_use = Date()
		
		rig.canopy_manufacturer = "Canopy manufacturer"
		rig.canopy_type = "Canopy type"
		rig.canopy_serial = "Canopy serial"
		rig.canopy_date_in_use = Date()
		
		_ = rig.save()
		
		return rig
	}
	
	func testSaveToDb() {
		let rig = BASERigTests.createBaseRig()
		XCTAssertNotNil(rig.id)
		
		let dbRig = BASERig.init(primaryKeyValue: rig.id)
		XCTAssertTrue(rig.isEqual(dbRig))
	}
}
