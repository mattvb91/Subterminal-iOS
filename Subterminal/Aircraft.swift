//
//  Aircraft.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 19/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SharkORM

class Aircraft: Model {
	dynamic var name: String?
	
	static func getAircrafts() -> [Int: String] {
		let aircrafts = Aircraft.query().fetch()
		var res = [Int: String]()
		
		for aircraft in aircrafts! {
			let aircraft = aircraft as! Aircraft
			res[Int(aircraft.id)] = aircraft.name
		}
		
		return res
	}
	
	static func getForSelect() -> [String] {
		var results = [String]()
		
		for item in getAircrafts() {
			results.append(item.value)
		}
		
		return results
	}
}
