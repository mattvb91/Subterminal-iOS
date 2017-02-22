//
//  Rig.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import Alamofire

class Rig: Synchronizable {
	
	override internal func getSyncIdentifier() -> String {
		return ""
	}

	override internal func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getGear()
	}

	
	override internal func getDeleteEndpoint() -> URLRequestConvertible {
		return Router.getGear()
	}

	
	override internal func getSyncEndpoint() -> URLRequestConvertible {
		return Router.getGear()
	}

    
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
}
