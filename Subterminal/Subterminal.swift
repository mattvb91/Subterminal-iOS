//
//  Subterminal.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 20/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

class Subterminal {

	static func getKey(key: String) -> String {
		if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
			// use swift dictionary as normal
			return dict[key] as! String
		}
		
		return ""
	}
}
