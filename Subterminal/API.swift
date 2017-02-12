//
//  API.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 11/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias ServiceResponse = (JSON, NSError) -> Void

class API: NSObject {
	
	let headesrs: HTTPHeaders = [
		"accept": "",
		"apiappkey": ""
	]
	
	static let instance = API()
	let baseURL = "http://192.168.1.11/api/"

	func getDropzones() {
		var test = Alamofire.request(baseURL + "dropzone", parameters: ["last_sync": "2000-01-01"], headers: headesrs).responseJSON { response in
			print(response.request)  // original URL request
			print(response.response) // HTTP URL response
			print(response.data)     // server data
			print(response.result)   // result of response serialization
			
			if let result = response.result.value {
				let items = result as! NSArray
				
				for item in items as! [NSDictionary] {
					let dropzone = Dropzone.build(json: JSON(item))
					dropzone.save()
				}
			}
		}
	}
}
