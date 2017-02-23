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
		"accept": Subterminal.getKey(key: "apiaccept"),
		"apiappkey": Subterminal.getKey(key: "apikey")
	]
	
	static let instance = API()
	let baseURL = "http://192.168.1.5/api/"

	func getAircraft() -> Void {
		Alamofire.request(Router.getAircraft()).responseJSON { response in
			if let result = response.result.value {
				let items = result as! NSArray
				
				for item in items as! [NSDictionary] {
					let data = JSON(item)

					var aircraft = Aircraft()
					aircraft.id = data["id"].numberValue
					aircraft.name = data["name"].string
					aircraft.save()
				}
			}
		}
	}
	
	static func initAPI() {
		API.instance.getAircraft()
		
		if Subterminal.user.isLoggedIn() {
			API.instance.downloadModel(model: Rig())
			API.instance.downloadModel(model: Skydive())
			API.instance.downloadModel(model: Suit())
		}
	}
	
	//Download the data for passed in model
	func downloadModel(model: Synchronizable) -> Void {
		
		Alamofire.request(model.getDownloadEndpoint()).responseJSON { response in
			if response.result.isSuccess, let result = response.result.value {
				let items = result as! NSArray
				
				for item in items as! [NSDictionary] {
					let syncClass = type(of: model)
					let syncItem = syncClass.build(json: JSON(item))
					syncItem.markSynced()
				}
			} else {
				debugPrint("Request Failed")
			}
		}
	}
	
	func createOrUpdateRemoveUser() {
		Alamofire.request(Router.updateUser()).responseJSON { response in
			if response.result.isSuccess, let result = response.result.value {
				API.initAPI()
			}
		}
	}
	
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
	
	func getDropzoneServices(dropzone: Dropzone!) {
		let url = baseURL + "dropzone/" + dropzone.id.stringValue + "/services"
		
		Alamofire.request(url, headers: headerss).responseJSON { response in
			if let result = response.result.value {
				debugPrint(response)
				let items = result as! NSArray
				
				dropzone.services = items as! [String]

				NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dropzoneServices"), object: nil)
			}
		}
	}
}
