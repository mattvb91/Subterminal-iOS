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
import SearchTextField
import SharkORM

class Exit: Synchronizable {
	
	dynamic var name,
		global_id,
		exit_description: String?
	
	dynamic var rockdrop_distance,
		altitude_to_landing,
		object_type: NSNumber?
	
	dynamic var height_unit: NSNumber!
	
	dynamic var latitude: Double = 0.0
	dynamic var longtitude: Double = 0.0
	
	var details: ExitDetails?
	
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
	
	static func getTypesForSelect() -> [String] {
		var res = [String]()
		
		for type in types {
			res.append(type.value)
		}
		
		return res
	}
	
	//Calculate rockdrop time
	func getFormattedRockdropTime() -> String {
		if self.rockdrop_distance == nil {
			return ""
		}
		
		//Convert everything to meter first
		let convertedDistance = Subterminal.convertToUnit(distance: Double(self.rockdrop_distance!), fromUnit: Int(self.height_unit), toUnit: UnitLength.meters)
		let time = sqrt(2 * Double(convertedDistance) / 9.8) as Double
		
		return time.roundTo(places: 1).description + "s"
	}
	
	override func getSyncEndpoint() -> URLRequestConvertible {
		return Router.syncExit(model: self)
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		return Router.deleteExit(model: self)
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getExits(lastSync: API.getLastRequestTime(requestName: self.getSyncIdentifier()))
	}
	
	override func getSyncIdentifier() -> String {
		return "SYNC_EXITS"
	}
	
	override class func defaultValuesForEntity() -> [AnyHashable: Any] {
		var defaults = [
			"height_unit": Subterminal.HEIGHT_UNIT_IMPERIAL,
			"latitude": 0.0,
			"longtitude": 0.0
		] as [String : Any]
		
		defaults.merge(other: super.defaultValuesForEntity() as! Dictionary<String, Int>)
		
		return defaults
	}

	
	override class func build(json: JSON) -> Exit {
		let exit = Exit()
		
		if json["global_id"].string == nil {
			exit.id = json["remote_id"].intValue as? NSNumber
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
		
		if json["details"].exists() {
			exit.details = ExitDetails.build(json: json["details"])
		}
		
		return exit
	}
	
	override func toJSON() -> [String: Any] {
		var values = [
			"name": name,
			"description": exit_description,
			"rockdrop_distance": rockdrop_distance,
			"altitude_to_landing": altitude_to_landing,
			"object_type": object_type,
			"height_unit": height_unit,
			"latitude": latitude,
			"longtitude": longtitude
		] as [String : Any]
		
		values.merge(other: super.toJSON())
		
		return values
	}
	
	override func isEqual(_ object: Any?) -> Bool {
		if let object = object as? Exit {
			return name == object.name &&
				global_id == object.global_id &&
				exit_description == object.exit_description &&
				rockdrop_distance == object.rockdrop_distance &&
				altitude_to_landing == object.altitude_to_landing &&
				object_type == object.object_type &&
				height_unit == object.height_unit &&
				latitude == object.latitude &&
				longtitude == object.longtitude
		}
		
		return false
	}
	
	//Check if we already have a matching exit
	func createOrUpdatePublicExit() {
		let privateRes = Exit.query().where(withFormat: "name = %@", withParameters: [self.name]).fetch() as SRKResultSet
		if privateRes.count > 0 {
			let privateExit = privateRes[0] as! Exit
			
			if privateExit.global_id == nil {
				return
			}
		}
		
		let publicRes = Exit.query().where(withFormat: "global_id = %@", withParameters: [self.global_id]).fetch() as SRKResultSet
		if publicRes.count > 0 {
			let publicExit = publicRes[0] as! Exit
			self.id = publicExit.id
			
			if self.isEqual(publicExit) == true {
				return
			}
		}
		
		if self.markSynced() {
			if self.details != nil {
				self.details?.exit_id = self.id
				_ = self.details?.save()
			}
		}
	}
	
	func getFormattedType() -> String? {
		//Get the formatted type string if we have an associated jump type value
		if self.object_type != nil {
			return Exit.types[(self.object_type?.intValue)!]!
		}
			
		return nil
	}
	
	func isGlobal() -> Bool {
		return self.global_id?.isEmpty == false
	}
	
	//Fetch all names for selection
	static func getOptionsForSelect() -> [SearchTextFieldItem] {
		var results = [SearchTextFieldItem]()
		
		for item in Exit.query().fetch() as SRKResultSet {
			let item = item as! Exit
			results.append(SearchTextFieldItem(title: item.name!, subtitle: item.id.description))
		}
		
		return results
	}
	
	//Get details associated with this exit
	func getDetails() -> ExitDetails? {
		let detailsRes = ExitDetails.query().where(withFormat: "exit_id = %@", withParameters: [self.id]).fetch() as SRKResultSet
		if detailsRes.count > 0 {
			self.details = detailsRes[0] as? ExitDetails
		}
		
		return self.details
	}
	
	private var _jumps: SRKResultSet?
	
	func getJumps() -> SRKResultSet {
		if self._jumps == nil {
			self._jumps = Jump.query().where(withFormat: "exit_id = %@", withParameters: [self.id]).fetch()
		}
		
		return self._jumps!
	}
	
	//Make sure we update any associated jumps
	override func remove() -> Bool {
		for jump in self.getJumps() {
			let jump = jump as! Jump
			jump.exit_id = nil
			_ = jump.save()
		}
		
		if getJumps().count > 0 {
			(self.getJumps()[0] as! Jump).sendModelNotification()
		}
		
		return super.remove()
	}
}
