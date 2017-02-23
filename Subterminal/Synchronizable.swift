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
	
	func markSynced() -> Bool {
		self.synced = Synchronizable.SYNC_COMPLETED
		return super.save()
	}
}
