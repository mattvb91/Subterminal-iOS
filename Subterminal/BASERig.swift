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
		fatalError("not implemented")
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getBaseGear()
	}
	
	override func getSyncIdentifier() -> String {
		fatalError("not implemented")
	}
	
	override class func build(json: JSON) -> BASERig {
		let rig = BASERig()
		
		rig.id = json["remote_id"].number
		rig.container_manufacturer = json["container_manufacturer"].string
		rig.container_type = json["container_type"].string
		rig.container_serial = json["container_serial"].string
		rig.container_date_in_use = DateHelper.stringToDate(string: json["container_date_in_use"].string!)
		rig.canopy_type = json["canopy_type"].string
		rig.canopy_serial = json["canopy_serial"].string
		rig.canopy_date_in_use = DateHelper.stringToDate(string: json["canopy_date_in_use"].string!)

		return rig
	}
	
	func getDisplayString() -> String {
		return self.container_manufacturer! + " / " + self.canopy_manufacturer! + " " + self.canopy_type!
	}

	static func getRigs() -> [Int: String] {
		let rigs = BASERig.query().fetch() as SRKResultSet
		
		var res = [Int: String]()
		
		for rig in rigs {
			let rig = rig as! BASERig
			let displayString = rig.container_manufacturer! + " / " + rig.canopy_manufacturer! + " " + rig.canopy_type!
			res[Int(rig.id)] = rig.id.description + " - " + displayString
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

}
