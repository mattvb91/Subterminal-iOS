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

class Rig: Synchronizable {
	
	dynamic var container_manufacturer,
	container_model,
	container_serial,
	container_date_in_use,
	main_manufacturer,
	main_model,
	main_serial,
	main_date_in_use,
	reserve_manufacturer,
	reserve_model,
	reserve_serial,
	reserve_date_in_use,
	aad_manufacturer,
	aad_model,
	aad_serial,
	aad_date_in_use: String?

	
	override internal func getSyncIdentifier() -> String {
		return ""
	}

	override internal func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getSkyGear()
	}

	
	override internal func getDeleteEndpoint() -> URLRequestConvertible {
		return Router.getSkyGear()
	}

	
	override internal func getSyncEndpoint() -> URLRequestConvertible {
		return Router.getSkyGear()
	}

	override class func build(json: JSON) -> Rig {
		let rig = Rig()
		
		rig.id = json["remote_id"].intValue as NSNumber!
		rig.container_manufacturer = json["container_manufacturer"].string
		rig.container_model = json["container_model"].string
		rig.container_serial = json["container_serial"].string
		rig.container_date_in_use = json["container_date_in_use"].string

		rig.main_manufacturer = json["main_manufacturer"].string
		rig.main_model = json["main_model"].string
		rig.main_serial = json["main_serial"].string
		rig.main_date_in_use = json["main_date_in_use"].string

		rig.reserve_manufacturer = json["reserve_manufacturer"].string
		rig.reserve_model = json["reserve_model"].string
		rig.reserve_serial = json["reserve_serial"].string
		rig.reserve_date_in_use = json["reserve_date_in_use"].string
		
		rig.aad_manufacturer = json["aad_manufacturer"].string
		rig.aad_model = json["aad_model"].string
		rig.aad_serial = json["aad_serial"].string
		rig.aad_date_in_use = json["aad_date_in_use"].string

		return rig
	}
	
}
