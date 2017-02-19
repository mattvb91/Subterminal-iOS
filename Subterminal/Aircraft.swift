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
	
	static func getForSelect() -> [String] {
		
		var results = [String]()
		let items = Aircraft.query().fetch()
		
		for item in items! {
			let item = item as? Aircraft
			results.append((item?.name!)!)
		}
		
		return results
	}
}
