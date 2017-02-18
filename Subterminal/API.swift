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
import ImageSlideshow

class API: NSObject {
	
	let headerss: HTTPHeaders = [
		"accept": "",
		"apiappkey": ""
	]
	
	static let instance = API()
	let baseURL = "http://192.168.1.11/api/"

	func getDropzones() -> Void {
		Alamofire.request(baseURL + "dropzone", parameters: ["last_sync": "2000-01-01"], headers: headerss).responseJSON { response in
			if let result = response.result.value {
				let items = result as! NSArray
				
				for item in items as! [NSDictionary] {
					let dropzone = Dropzone.build(json: JSON(item))
					_ = dropzone.save()
				}
			}
		}
	}
	
	func getDropzoneImages(dropzone: Dropzone!) {
		let url = baseURL + "dropzone/" + dropzone.id.stringValue + "/images"
		
		Alamofire.request(url, headers: headerss).responseJSON { response in
			if let result = response.result.value {
				debugPrint(response)
				let items = result as! NSArray
				
				var images = [AlamofireSource]()
				for item in items as! [NSDictionary] {
					debugPrint(item)
					
					let data = JSON(item)
					let url = "https://skydivelocations.com/image/" + data["filename"].string! + "?full=true"
					
					images.append(AlamofireSource(urlString: url)!)
				}
			
				dropzone.images = images
				NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dropzoneImages"), object: nil)
			}
		}
	}
}
