//
//  Subterminal.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 20/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Subterminal {
	
	static let MODE_SKYDIVE = 0
	static let MODE_BASE = 1
	
	static let HEIGHT_UNIT_METRIC = 0
	static let HEIGHT_UNIT_IMPERIAL = 1
	
	private static var map: MKMapView? = nil
	
	public static var mode = Subterminal.MODE_SKYDIVE
	
	static var units = [
		Subterminal.HEIGHT_UNIT_METRIC: UnitLength.meters,
		Subterminal.HEIGHT_UNIT_IMPERIAL: UnitLength.feet
	]
	
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
	
	static func convertToDefaultUnit(distance: Double, fromUnit: Int) -> String {
		var distance = Measurement(value: distance, unit: Subterminal.units[fromUnit]!)
		let toUnit = Subterminal.units[UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_HEIGHT_UNIT)]! as UnitLength
		distance.convert(to: toUnit)
		
		let height = Int(distance.value)
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = NumberFormatter.Style.decimal
		
		return numberFormatter.string(from: NSNumber(value: height))! + toUnit.symbol
	}
	
	static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
		return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
	}
	
	static func getMap() -> MKMapView {
		if map == nil {
			map = MKMapView()
		}
		
		return map!
	}
	
	static func clearMap() {
		let annotations = self.getMap().annotations
		if !annotations.isEmpty {
			for _annotation in annotations {
				if let annotation = _annotation as? MKAnnotation
				{
					self.getMap().removeAnnotation(annotation)
				}
			}
		}
		
		self.getMap().removeOverlays(self.getMap().overlays)
	}
}

extension Double {
	/// Rounds the double to decimal places value
	func roundTo(places:Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}

extension Dictionary {
	mutating func merge(other:Dictionary) {
		for (key,value) in other {
			self.updateValue(value, forKey:key)
		}
	}
}
