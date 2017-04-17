//
//  Synchronizable.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 22/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Synchronizable: Model, SyncProtocol {
	
	dynamic var synced: NSNumber = 0
	dynamic var deleted: NSNumber = 0
	
	static let SYNC_COMPLETED: NSNumber = 1
	static let SYNC_REQUIRED: NSNumber = 0
	
	static let DELETED_TRUE: NSNumber = 1
	static let DELETED_FALSE: NSNumber = 0
	
	override class func defaultValuesForEntity() -> [AnyHashable: Any] {
		return ["synced": 0, "deleted": 0]
	}
	
	override func save() -> Bool {
		synced = Synchronizable.SYNC_REQUIRED
		
		let res = super.save()
		
		if Subterminal.user.isLoggedIn() == true && Subterminal.user.isPremium() == true {
			API.instance.syncModel(model: self)
		}
		
		return res
	}
	
	/*
	 * Remove entity & synchronize to server
	 */
	override func remove() -> Bool {
		if self.deleted == Synchronizable.DELETED_FALSE {
			self.deleted = Synchronizable.DELETED_TRUE
			
			let res = super.save()
			
			if Subterminal.user.isLoggedIn() == true && Subterminal.user.isPremium() == true {
				API.instance.deleteModel(model: self)
			}
			
			return res
		} else {
			return super.remove()
		}
	}
	
	override func entityDidDelete() {
		super.entityDidDelete()
	}
	
	func getSyncEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
	}
	
	func getDeleteEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")

	}
	
	func getDownloadEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")

	}
	
	func getSyncIdentifier() -> String {
		fatalError("not implemented")
	}
	
	class func build(json: JSON) -> Synchronizable {
		fatalError("not implemented")
	}
	
	func toJSON() -> [String: Any] {
		return ["_id": id]
	}
	
	func markSynced() -> Bool {
		self.synced = Synchronizable.SYNC_COMPLETED
		return super.save()
	}
	
	/*
	func getForSync() -> Synchronizable {
		let model = type(of: self) as Synchronizable.Type
		
		model.query().whereWithFormat
		
		return
	}*/
	
	//Sync all required entities up to the server
	func syncEntities() -> Void {
		//let exits = Exit.getForSync()
		
	}
}
