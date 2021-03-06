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
import ReachabilitySwift
import SharkORM
import SwiftSpinner

class API: NSObject {
	
	static let LAST_DROPZONE_REQUEST = "last_dropzone_request"
	static let LAST_TUNNEL_REQUEST = "last_tunnel_request"

	let headerss: HTTPHeaders = [
		"accept": Subterminal.getKey(key: "apiaccept"),
		"apiappkey": Subterminal.getKey(key: "apikey")
	]
	
	static let instance = API()
	static let reachability = Reachability()!

	func getAircraft() -> Void {
		Alamofire.request(Router.getAircraft()).responseJSON { response in
			if let result = response.result.value {
				let items = result as! NSArray
				
				for item in items as! [NSDictionary] {
					let data = JSON(item)

					let aircraft = Aircraft()
					aircraft.id = data["id"].numberValue
					aircraft.name = data["name"].string
					_ = aircraft.save()
				}
			}
		}
	}
	
	static func initAPI() {
		
		if reachability.isReachable == false {
			return
		}
		
		DispatchQueue.global(qos: .background).async {
			API.instance.getAircraft()
			API.instance.getDropzones()
			API.instance.getPublicExits()
			API.instance.getTunnels()
		
			if Subterminal.user.isLoggedIn() && Subterminal.user.isPremium() == true {
				API.instance.downloadModel(model: Rig())
				API.instance.downloadModel(model: Skydive())
				API.instance.downloadModel(model: Suit())
				API.instance.downloadModel(model: Exit())
				API.instance.downloadModel(model: BASERig())
				API.instance.downloadModel(model: Jump())
				
				Synchronizable.syncEntities()
			}
		}
	}
	
	//Download the data for passed in model
	func downloadModel(model: Synchronizable) -> Void {
		
		if Subterminal.user.isLoggedIn() == false {
			return
		}
		
		Alamofire.request(model.getDownloadEndpoint()).responseJSON { response in
			if response.result.isSuccess, let result = response.result.value {

				let items = result as! NSArray
				
				SRKTransaction.transaction({
					for item in items as! [NSDictionary] {
						let syncClass = type(of: model)
						let syncItem = syncClass.build(json: JSON(item))
						_ = syncItem.markSynced()
					}
				}) {
					//Failed
					return
				}
				
				API.setLastRequestTime(name: model.getSyncIdentifier(), time: response.response?.allHeaderFields["server_time"] as! String)

			} else if response.response?.statusCode == 401 {
				Subterminal.user.logout()
				return
			}
		}
	}
	
	func createOrUpdateRemoveUser() {
		Alamofire.request(Router.updateUser()).responseJSON { response in
			if response.result.isSuccess, let result = response.result.value {
				let result = JSON(result)
				UserDefaults.standard.set(result["user"]["is_premium"].intValue == 1 ? true : false, forKey: "user_premium")
				
				API.initAPI()
				
				//Refresh back to dashboard
				Subterminal.changeMode(mode: Subterminal.mode)
			}
		}
	}
	
	func getUser() {
		Alamofire.request(Router.getUser()).responseJSON { response in
			if response.result.isSuccess, let result = response.result.value {
				let result = JSON(result)
				UserDefaults.standard.set(result["is_premium"].intValue == 1 ? true : false, forKey: "user_premium")
				
				API.initAPI()
				
				//Refresh back to dashboard
				Subterminal.changeMode(mode: Subterminal.mode)
			}
		}
	}
	
	//Send receipt to server & validate before updating user
	func sendPurchaseReceipt(receipt: String) {
		Alamofire.request(Router.receipt(receipt: receipt)).responseJSON { response in
			if response.response?.statusCode == 201 {
				//Successfully validated receipt. Get user again
				self.getUser()
			}
		}
	}
	
	func authenticate(email: String, password: String) {
		Alamofire.request(Router.baseURL + "/auth", method: .post, parameters: ["email": email, "password": password], headers: headerss).responseJSON { response in
			if response.response?.statusCode == 200, let result = response.result.value {
				let result = JSON(result)
				Subterminal.user.setToken(token: result["token"].stringValue)
				
				self.getUser()
			}
			
			SwiftSpinner.hide()
		}
	}
	
	func getDropzones() -> Void {
		Alamofire.request(Router.baseURL + "/dropzone", parameters: ["last_sync": API.getLastRequestTime(requestName: API.LAST_DROPZONE_REQUEST)], headers: headerss).responseJSON { response in
			if let result = response.result.value {
				let items = result as! NSArray
				
				SRKTransaction.transaction({
					for item in items as! [NSDictionary] {
						let dropzone = Dropzone.build(json: JSON(item))
						if dropzone.save() {
							dropzone.updateAircraft(json: JSON(item))
						}
					}
				}) {
					//Failed
					return
				}
		
				API.setLastRequestTime(name: API.LAST_DROPZONE_REQUEST, time: response.response?.allHeaderFields["server_time"] as! String)
				NotificationCenter.default.post(name: NSNotification.Name(rawValue: Dropzone.getNotificationName()), object: nil)
			}
		}
	}
	
	func getTunnels() -> Void {
		Alamofire.request(Router.baseURL + "/tunnel", parameters: ["last_sync": API.getLastRequestTime(requestName: API.LAST_TUNNEL_REQUEST)], headers: headerss).responseJSON { response in
			if let result = response.result.value {
				let items = result as! NSArray
				
				for item in items as! [NSDictionary] {
					let tunnel = Tunnel.build(json: JSON(item))
					_ = tunnel.save()
				}
				
				API.setLastRequestTime(name: API.LAST_TUNNEL_REQUEST, time: response.response?.allHeaderFields["server_time"] as! String)
				NotificationCenter.default.post(name: NSNotification.Name(rawValue: Tunnel.getNotificationName()), object: nil)
			}
		}
	}
	
	func getPublicExits() -> Void {
		Alamofire.request(Router.getPublicExits()).responseJSON { response in
			if let result = response.result.value {
				let items = result as! NSArray
				
				for item in items as! [NSDictionary] {
					let exit = Exit.build(json: JSON(item))
					exit.createOrUpdatePublicExit()
				}
			}
		}
	}

	
	func getDropzoneImages(dropzone: Dropzone!) {
		let url = Router.baseURL + "/dropzone/" + dropzone.id.stringValue + "/images"
		
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
	
	func getTunnelImages(tunnel: Tunnel!) {
		let url = Router.baseURL + "/tunnel/" + tunnel.id.stringValue + "/images"
		
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
				
				tunnel.images = images
				NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tunnelImages"), object: nil)
			}
		}
	}
	
	func getDropzoneServices(dropzone: Dropzone!) {
		let url = Router.baseURL + "/dropzone/" + dropzone.id.stringValue + "/services"
		
		Alamofire.request(url, headers: headerss).responseJSON { response in
			if let result = response.result.value {
				debugPrint(response)
				let items = result as! NSArray
				
				dropzone.services = items as? [String]

				NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dropzoneServices"), object: nil)
			}
		}
	}
	
	func syncModel(model:Synchronizable!) {
		Alamofire.request(model.getSyncEndpoint()).responseJSON { response in
			if response.response?.statusCode == 201 {
				_ = model.markSynced()
				API.setLastRequestTime(name: model.getSyncIdentifier(), time: response.response?.allHeaderFields["server_time"] as! String)
			}
			
			//Not authorized. Update logged in
			if response.response?.statusCode == 401 {
				Subterminal.user.logout()
			}
		}
	}
	
	func deleteModel(model: Synchronizable) {
		Alamofire.request(model.getDeleteEndpoint()).responseJSON { response in
			if response.response?.statusCode == 204 || response.response?.statusCode == 403 {
				_ = model.remove()
			}
			
			//Not authorized. Update logged in
			if response.response?.statusCode == 401 {
				Subterminal.user.logout()
			}
		}
	}
	
	static func setLastRequestTime(name: String, time: String) {
		UserDefaults.standard.setValue(time, forKey: name)
	}
	
	static func getLastRequestTime(requestName: String) -> String {
		if UserDefaults.standard.string(forKey: requestName) != nil {
			return UserDefaults.standard.string(forKey: requestName)!
		}
		
		return "2000-01-01"
	}
}
