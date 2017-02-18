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
	
}
