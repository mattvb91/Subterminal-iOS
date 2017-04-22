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
import SharkORM

class Synchronizable: Model, SyncProtocol {
	
	dynamic var synced: NSNumber = 0
	dynamic var deleted: NSNumber = 0
	
	static let SYNC_COMPLETED: NSNumber = 1
	static let SYNC_REQUIRED: NSNumber = 0
	
	static let DELETED_TRUE: NSNumber = 1
	static let DELETED_FALSE: NSNumber = 0
	
	override class func defaultValuesForEntity() -> [AnyHashable: Any] {
		return ["synced": SYNC_REQUIRED, "deleted": DELETED_FALSE]
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
	
	//Fetch all items that need to be synchronized
	static func getForSync() -> SRKResultSet {
		return self.query().where("synced = 0").fetch()
	}
	
	//Fetch all items that need to be deleted
	static func getForDelete() -> SRKResultSet {
		return self.query().where("deleted = 1").fetch()
	}
	
	//Sync all required entities up to the server
	static func syncEntities() -> Void {
		
		for exit in Exit.getForSync() {
			API.instance.syncModel(model: exit as! Exit)
		}
		
		for exit in Exit.getForDelete() {
			API.instance.deleteModel(model: exit as! Exit)
		}
		
		for rig in BASERig.getForSync() {
			API.instance.syncModel(model: rig as! BASERig)
		}
		
		for rig in BASERig.getForDelete() {
			API.instance.deleteModel(model: rig as! BASERig)
		}
		
		for suit in Suit.getForSync() {
			API.instance.syncModel(model: suit as! Suit)
		}
		
		for suit in Suit.getForDelete() {
			API.instance.deleteModel(model: suit as! Suit)
		}
		
		for jump in Jump.getForSync() {
			API.instance.syncModel(model: jump as! Jump)
		}
		
		for jump in Jump.getForDelete() {
			API.instance.deleteModel(model: jump as! Jump)
		}
		
		for rig in Rig.getForSync() {
			API.instance.syncModel(model: rig as! Rig)
		}
		
		for rig in Rig.getForDelete() {
			API.instance.deleteModel(model: rig as! Rig)
		}
		
		for skydive in Skydive.getForSync() {
			API.instance.syncModel(model: skydive as! Skydive)
		}
		
		for skydive in Skydive.getForDelete() {
			API.instance.deleteModel(model: skydive as! Skydive)
		}
	}
}
