//
//  Rig.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SharkORM

class Rig: Synchronizable {
	
	dynamic var container_manufacturer,
		container_model,
		container_serial,
		main_manufacturer,
		main_model,
		main_serial,
		reserve_manufacturer,
		reserve_model,
		reserve_serial,
		aad_manufacturer,
		aad_model,
		aad_serial: String?
	
	dynamic var container_date_in_use,
		main_date_in_use,
		reserve_date_in_use,
		aad_date_in_use: Date?
	

	
	override internal func getSyncIdentifier() -> String {
		return "SYNC_SKYDIVE_RIGS"
	}

	override internal func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getSkyGear()
	}

	
	override internal func getDeleteEndpoint() -> URLRequestConvertible {
		return Router.getSkyGear()
	}

	
	override internal func getSyncEndpoint() -> URLRequestConvertible {
		return Router.syncSkydiveRig(model: self)
	}

	override class func build(json: JSON) -> Rig {
		let rig = Rig()
		
		rig.id = json["remote_id"].intValue as NSNumber!
		rig.container_manufacturer = json["container_manufacturer"].string
		rig.container_model = json["container_model"].string
		rig.container_serial = json["container_serial"].string
		if json["container_date_in_use"].string?.isEmpty == false {
			rig.container_date_in_use = DateHelper.stringToDate(string: json["container_date_in_use"].string!)
		}

		rig.main_manufacturer = json["main_manufacturer"].string
		rig.main_model = json["main_model"].string
		rig.main_serial = json["main_serial"].string
		if json["main_date_in_use"].string?.isEmpty == false {
			rig.main_date_in_use = DateHelper.stringToDate(string: json["main_date_in_use"].string!)
		}

		rig.reserve_manufacturer = json["reserve_manufacturer"].string
		rig.reserve_model = json["reserve_model"].string
		rig.reserve_serial = json["reserve_serial"].string
		if json["reserve_date_in_use"].string?.isEmpty == false {
			rig.reserve_date_in_use = DateHelper.stringToDate(string: json["reserve_date_in_use"].string!)
		}
		
		rig.aad_manufacturer = json["aad_manufacturer"].string
		rig.aad_model = json["aad_model"].string
		rig.aad_serial = json["aad_serial"].string
		if json["aad_date_in_use"].string?.isEmpty == false {
			rig.aad_date_in_use = DateHelper.stringToDate(string: json["aad_date_in_use"].string!)
		}

		return rig
	}
	
	override func toJSON() -> [String : Any] {
		var values = [
			"container_manufacturer": container_manufacturer,
			"container_model": container_model,
			"container_serial": container_serial,
			"container_date_in_use": DateHelper.dateToString(date: container_date_in_use!),
			
			"main_manufacturer": main_manufacturer,
			"main_model": main_model,
			"main_serial": main_serial,
			"main_date_in_use": DateHelper.dateToString(date: main_date_in_use!),
			
			"reserve_manufacturer": reserve_manufacturer,
			"reserve_model": reserve_model,
			"reserve_serial": reserve_serial,
			"reserve_date_in_use": DateHelper.dateToString(date: reserve_date_in_use!),
			
			"aad_manufacturer": aad_manufacturer,
			"aad_model": aad_model,
			"aad_serial": aad_serial,
			"aad_date_in_use": DateHelper.dateToString(date: aad_date_in_use!)
		] as [String : Any]
		
		values.merge(other: super.toJSON())
		
		return values
	}
	
	static func getRigs() -> [Int: String] {
		let rigs = Rig.query().fetch() as SRKResultSet

		var res = [Int: String]()
		
		for rig in rigs {
			let rig = rig as! Rig
			let displayString = rig.container_manufacturer! + " / " + rig.main_manufacturer! + " " + rig.main_model!
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
	
	private var _skydives: SRKResultSet?
	
	func getSkydives() -> SRKResultSet {
		if self._skydives == nil {
			self._skydives = Skydive.query().where(withFormat: "rig_id = %@", withParameters: [self.id]).fetch()
		}
		
		return self._skydives!
	}
	
	//Make sure we update any associated jumps
	override func remove() -> Bool {
		for skydive in self.getSkydives() {
			let skydive = skydive as! Skydive
			skydive.rig_id = nil
			_ = skydive.save()
		}
		
		if getSkydives().count > 0 {
			(self.getSkydives()[0] as! Skydive).sendModelNotification()
		}
		
		return super.remove()
	}
	
	override func isEqual(_ object: Any?) -> Bool {
		if let object = object as? Rig {
		return
			container_manufacturer == object.container_manufacturer &&
			container_model == object.container_model &&
			container_serial == object.container_serial &&
			main_manufacturer == object.main_manufacturer &&
			main_model == object.main_model &&
			main_serial == object.main_serial &&
			reserve_manufacturer == object.reserve_manufacturer &&
			reserve_model == object.reserve_model &&
			reserve_serial == object.reserve_serial &&
			aad_manufacturer == object.aad_manufacturer &&
			aad_model == object.aad_model &&
			aad_serial == object.aad_serial &&
			container_date_in_use == object.container_date_in_use &&
			main_date_in_use == object.main_date_in_use &&
			reserve_date_in_use == object.reserve_date_in_use &&
			aad_date_in_use == object.aad_date_in_use
		} else {
			return false
		}
	}

	
}
