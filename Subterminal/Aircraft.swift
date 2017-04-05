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
	
	override func isEqual(_ object: Any?) -> Bool {
		if let object = object as? Aircraft {
			return name == object.name
		} else {
			return false
		}
	}
	
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
		
		results = results.sorted {$0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending}
		
		return results
	}
}
