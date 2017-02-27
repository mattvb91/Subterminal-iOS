//
//  Exit.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 27/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Exit: Synchronizable {
	
	dynamic var name,
		global_id,
		exit_description: String?
	
	dynamic var rockdrop_distance,
		altitude_to_landing,
		object_type,
		height_unit: NSNumber?
	
	dynamic var latitude: Double = 0.0
	dynamic var longtitude: Double = 0.0
	
	static let TYPE_BUILDING = 1;
	static let TYPE_ANTENNA = 2;
	static let TYPE_SPAN = 3;
	static let TYPE_EARTH = 4;
	static let TYPE_OTHER = 5;
	
	static var types = [
		TYPE_BUILDING: "Building",
		TYPE_ANTENNA: "Antenna",
		TYPE_SPAN: "Span",
		TYPE_EARTH: "Earth",
		TYPE_OTHER: "Other",
	]
	
	override func getSyncEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
		
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getExits()		
	}
	
	override func getSyncIdentifier() -> String {
		fatalError("not implemented")
	}
	
	
	override class func build(json: JSON) -> Exit {
		let exit = Exit()
		
		if let id = json["remote_id"].intValue as NSNumber! {
			exit.id = id
		}
		
		exit.name = json["name"].string
		exit.global_id = json["global_id"].string
		exit.exit_description = json["description"].string
		exit.rockdrop_distance = json["rockdrop_distance"].numberValue
		exit.altitude_to_landing = json["altitude_to_landing"].numberValue
		exit.object_type = json["object_type"].numberValue
		exit.height_unit = json["height_unit"].numberValue
		exit.latitude = json["latitude"].doubleValue
		exit.longtitude = json["longtitude"].doubleValue
		
		return exit
	}
	
	func getFormattedType() -> String? {
		//Get the formatted type string if we have an associated jump type value
		if self.object_type != nil {
			return Exit.types[(self.object_type?.intValue)!]!
		}
			
		return nil
	}
}
