//
//  Dropzone.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import ImageSlideshow
import SharkORM

class Dropzone: Model {
    
    dynamic var dropzone_description,
        name,
        website,
        phone,
        email,
        formatted_address,
        local,
        country: String?
    
	dynamic var latitude: Double = 0.0
	dynamic var longtitude: Double = 0.0
	
	var images: [AlamofireSource]?
	var services: [String]?
	
	class func build(json: JSON) -> Dropzone {
		var dropzone = Dropzone()
		
		dropzone.id = json["id"].intValue as NSNumber!
		dropzone.dropzone_description = json["description"].string
		dropzone.name = json["name"].string
		dropzone.website = json["website"].string
		dropzone.phone = json["phone"].string
		dropzone.email = json["email"].string
		dropzone.formatted_address = json["formatted_address"].string
		dropzone.local = json["local"].string
		dropzone.country = json["country"].string
		dropzone.latitude = json["latitude"].doubleValue
		dropzone.longtitude = json["longtitude"].doubleValue
		
		return dropzone
	}
	
	func updateAircraft(json: JSON) {
		var items = json["dropzone_aircraft"].array
		
		for item in items! {
			let aircraft_id = item["aircraft_id"].intValue
			
			if DzAircraft.query().where(withFormat: "aircraft_id = %@ AND dropzone_id = %@", withParameters: [aircraft_id, self.id]).fetch().count == 0 {
				let dzAircraft = DzAircraft()
				dzAircraft.dropzone_id = self.id
				dzAircraft.aircraft_id = aircraft_id as NSNumber?
				dzAircraft.save()
			}
		}
	}
	
	func aircraftCount() -> Int {
		return DzAircraft.query().where(withFormat: "dropzone_id = %@", withParameters: [self.id]).fetch().count
	}
	
	func getFormattedAircrafts() -> String {
		let dzAircrafts = DzAircraft.query().where(withFormat: "dropzone_id = %@", withParameters: [self.id]).fetch() as? SRKResultSet
		
		var result = ""
		for dzAircraft in dzAircrafts! {
			let dzAircraft = dzAircraft as? DzAircraft
			let aircraft = Aircraft.object(withPrimaryKeyValue: dzAircraft?.aircraft_id) as? Aircraft
			result = result + (aircraft?.name!)! + ", "
		}
		
		return result
	}
	
	//Fetch all names for selection
	static func getOptionsForSelect() -> [String] {
		var results = [String]()
		
		for item in Dropzone.query().fetch() as SRKResultSet {
			var item = item as? Dropzone
			results.append((item?.name!)!)
		}
		
		return results
	}
	
}
