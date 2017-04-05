//
//  ExitTests.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 26/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import XCTest

class ExitTests: XCTestCase {
	
	static func createExit() -> Exit {
		let exit = Exit()
		exit.name = "Test exit"
		exit.altitude_to_landing = 1111
		exit.rockdrop_distance = 145
		exit.exit_description = "Exit description"
		exit.latitude = 2.1334
		exit.longtitude = -1.3455
		exit.object_type = Exit.TYPE_OTHER as NSNumber?
		
		_ = exit.save()
		
		return exit
	}
	
	func testSaveExitToDb() {
		let exit = ExitTests.createExit()
		XCTAssertNotNil(exit.id)
		
		let dbExit = Exit.object(withPrimaryKeyValue: exit.id)
		XCTAssertTrue(exit.isEqual(dbExit))
	}
}
