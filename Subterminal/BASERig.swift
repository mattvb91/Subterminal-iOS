//
//  BASERig.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import SharkORM

class BASERig: Synchronizable {
	
	dynamic var container_manufacturer,
		container_type: String!
	
	dynamic var
		container_serial,
		canopy_manufacturer,
		canopy_type,
		canopy_serial: String?
	
	dynamic var canopy_date_in_use,
		container_date_in_use: Date?
	
	override func getSyncEndpoint() -> URLRequestConvertible {
		return Router.syncBaseRig(model: self)
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		return Router.deleteBaseRig(model: self)
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getBaseGear(lastSync: API.getLastRequestTime(requestName: self.getSyncIdentifier()))
	}
	
	override func getSyncIdentifier() -> String {
		return "SYNC_BASE_RIGS"
	}
	
	override class func build(json: JSON) -> BASERig {
		let rig = BASERig()
		
		rig.id = json["remote_id"].number
		rig.container_manufacturer = json["container_manufacturer"].string
		rig.container_type = json["container_type"].string
		rig.container_serial = json["container_serial"].string
		rig.container_date_in_use = DateHelper.stringToDate(string: json["container_date_in_use"].string!)
		rig.canopy_manufacturer = json["canopy_manufacturer"].string
		rig.canopy_type = json["canopy_type"].string
		rig.canopy_serial = json["canopy_serial"].string
		rig.canopy_date_in_use = DateHelper.stringToDate(string: json["canopy_date_in_use"].string!)

		return rig
	}
	
	func getDisplayString() -> String {
		var res = self.container_manufacturer!
			
		if self.canopy_manufacturer != nil {
			res += " / " + self.canopy_manufacturer!
		}
		
		if self.canopy_type != nil {
			res += " " + self.canopy_type!
		}
		
		return res
	}
	
	override func toJSON() -> [String : Any] {
		var values = [
			"container_manufacturer": container_manufacturer,
			"container_type": container_type,
			"container_serial": container_serial,
			"container_date_in_use": DateHelper.dateToString(date: container_date_in_use!),
			"canopy_manufacturer": canopy_manufacturer,
			"canopy_type": canopy_type,
			"canopy_serial": canopy_serial,
			"canopy_date_in_use": DateHelper.dateToString(date: canopy_date_in_use!)
			] as [String: Any]
		
		values.merge(other: super.toJSON())
		
		return values
	}

	static func getRigs() -> [Int: String] {
		let rigs = BASERig.query().fetch() as SRKResultSet
		
		var res = [Int: String]()
		
		for rig in rigs {
			let rig = rig as! BASERig
			res[Int(rig.id)] = rig.id.description + " - " + rig.getDisplayString()
		}
		
		return res
	}
	
	//Return all available rigs
	static func getOptionsForSelect() -> [String] {
		let rigs = getRigs()
		
		var res = [String]()
		res.append(" - ")
		for rig in rigs as NSDictionary {
			res.append(rig.value as! String)
		}
		
		return res
	}
	
	private var _jumps: SRKResultSet?
	
	func getJumps() -> SRKResultSet {
		if self._jumps == nil {
			self._jumps = Jump.query().where(withFormat: "gear_id = %@", withParameters: [self.id]).fetch()
		}
		
		return self._jumps!
	}
	
	//Make sure we update any associated jumps
	override func remove() -> Bool {
		for jump in self.getJumps() {
			let jump = jump as! Jump
			jump.gear_id = nil
			_ = jump.save()
		}
		
		if getJumps().count > 0 {
			(self.getJumps()[0] as! Jump).sendModelNotification()
		}
		
		return super.remove()
	}

	override func isEqual(_ object: Any?) -> Bool {
		if let object = object as? BASERig {
			return
				container_manufacturer == object.container_manufacturer &&
				container_type == object.container_type &&
				container_serial == object.container_serial &&
				container_date_in_use?.description == object.container_date_in_use?.description &&
				canopy_manufacturer == object.canopy_manufacturer &&
				canopy_type == object.canopy_type &&
				canopy_serial == object.canopy_serial &&
				canopy_date_in_use?.description == object.canopy_date_in_use?.description
		}
		
		return false
	}

}
