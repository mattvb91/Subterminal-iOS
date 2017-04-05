//
//  Tunnel.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 05/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tunnel: Model {
	
	dynamic var name: String!
	
	dynamic var website,
		phone,
		email,
		tunnel_description,
		formatted_address,
		local,
		country: String?
	
	dynamic var featured: NSNumber = 0
	
	dynamic var latitude: Double = 0.00
	dynamic var longtitude : Double = 0.00
	dynamic var tunnel_diameter: Double = 0.00
	dynamic var	tunnel_height: Double = 0.00

	class func build(json: JSON) -> Tunnel {
		let tunnel = Tunnel()
		
		tunnel.id = json["id"].intValue as NSNumber!
		tunnel.tunnel_description = json["description"].string
		tunnel.name = json["name"].string
		tunnel.website = json["website"].string
		tunnel.phone = json["phone"].string
		tunnel.email = json["email"].string
		tunnel.formatted_address = json["formatted_address"].string
		tunnel.local = json["local"].string
		tunnel.country = json["country"].string
		tunnel.latitude = json["latitude"].doubleValue
		tunnel.longtitude = json["longtitude"].doubleValue
		tunnel.featured = json["featured"].numberValue
		tunnel.tunnel_diameter = json["tunnel_diameter"].doubleValue
		tunnel.tunnel_height = json["tunnel_height"].doubleValue
		
		return tunnel
	}
	
	override class func defaultValuesForEntity() -> [AnyHashable: Any] {
		return [
			"featured": 0,
			"latitude": 0.00,
			"longtitude": 0.00,
			"tunnel_diameter": 0.00,
			"tunnel_height": 0.00
		]
	}
	
	override func isEqual(_ object: Any?) -> Bool {
		if let object = object as? Tunnel {
			return
				tunnel_description == object.tunnel_description &&
				name == object.name &&
				website == object.website &&
				phone == object.phone &&
				email == object.email &&
				formatted_address == object.formatted_address &&
				local == object.local &&
				country == object.country &&
				featured == object.featured &&
				latitude == object.latitude &&
				longtitude == object.longtitude &&
				tunnel_diameter == object.tunnel_diameter &&
				tunnel_height == object.tunnel_height
		} else {
			return false
		}
	}

}
