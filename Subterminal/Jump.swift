//
//  Jump.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Jump: Synchronizable {
	
	dynamic var jump_description: String?
	dynamic var date: Date?
	
	dynamic var gear_id,
		delay,
		exit_id,
		type,
		suit_id,
		pc_size,
		slider: NSNumber?
	
	static let SLIDER_DOWN = 0
	static let SLIDER_UP = 1
	static let SLIDER_OFF = 2
	
	static var slider_config = [
		SLIDER_DOWN: "Down",
		SLIDER_UP: "Up",
		SLIDER_OFF: "Off"
	]
	
	//Get the skydive types available for select
	static func getSliderConfigForDropdown() -> [String] {
		var results = [String]()
		
		for type in slider_config {
			results.append(type.value)
		}
		
		return results
	}
	
	func getFormattedSlider() -> String? {
		if self.slider != nil {
			return Jump.slider_config[(self.slider?.intValue)!]!
		}
		
		return nil
	}
	
	static let TYPE_SLICK = 0;
	static let TYPE_TRACKING = 1;
	static let TYPE_WINGSUIT = 2;
	
	static var jump_type = [
		TYPE_SLICK: "Slick",
		TYPE_TRACKING: "Tracking",
		TYPE_WINGSUIT: "Wingsuit"
	]
	
	func getFormattedType() -> String? {
		if self.type != nil {
			return Jump.jump_type[(self.type?.intValue)!]!
		}
		
		return nil
	}

	
	//Get the skydive types available for select
	static func getTypesForSelect() -> [String] {
		var results = [String]()
		
		for type in jump_type {
			results.append(type.value)
		}
		
		return results
	}
	
	static let pc_sizes = ["32", "36", "38", "40", "42", "46", "48"]
	
	override func getSyncEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
		
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getJumps()
	}
	
	override func getSyncIdentifier() -> String {
		fatalError("not implemented")
	}
	
	override class func build(json: JSON) -> Jump {
		let jump = Jump()
		
		jump.id = json["remote_id"].number
		jump.jump_description = json["description"].string
		jump.date = DateHelper.stringToDate(string: json["date"].string!)
		jump.gear_id = json["gear_id"].number
		jump.exit_id = json["exit_id"].number
		jump.delay = json["delay"].number
		jump.type = json["type"].number
		jump.suit_id = json["suit_id"].number
		jump.pc_size = json["pc_size"].number
		jump.slider = json["slider"].number
		
		super.build(json: json)

		return jump

	}
	
	func exit() -> Exit? {
		if self.exit_id != nil {
			return Exit.init(primaryKeyValue: self.exit_id)
		}
		
		return nil
	}

	func rig() -> BASERig? {
		if self.gear_id != nil, self.gear_id?.intValue != 0 {
			return BASERig.init(primaryKeyValue: self.gear_id) as! BASERig
		}
		
		return nil
	}
}
