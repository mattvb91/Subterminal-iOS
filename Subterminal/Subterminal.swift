//
//  Subterminal.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 20/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class Subterminal {
	
	static let MODE_SKYDIVE = 0
	static let MODE_BASE = 1
	
	static let HEIGHT_UNIT_METRIC = 0
	static let HEIGHT_UNIT_IMPERIAL = 1
	
	public static var mode = Subterminal.MODE_SKYDIVE
	public static var heightUnit = Subterminal.HEIGHT_UNIT_IMPERIAL
	
	public static var user = User()
	
	static func getKey(key: String) -> String {
		if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
			// use swift dictionary as normal
			return dict[key] as! String
		}
		
		return ""
	}
	
	static func changeMode(mode: Int) {
		Subterminal.mode = mode
		
		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		appDelegate?.window!.rootViewController = TabBarController()
	}
}
