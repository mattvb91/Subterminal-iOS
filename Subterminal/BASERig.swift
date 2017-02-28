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

}
