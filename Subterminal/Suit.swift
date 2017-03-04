//
//  Suit.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 23/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Suit: Synchronizable {
	
	dynamic var manufacturer,
		model,
		serial: String?
	
	dynamic var date_in_use: Date?
	dynamic var type: NSNumber?
	
	static let TYPE_WINGSUIT = 0;
	static let TYPE_TRACKING = 1;

	static var types = [
		TYPE_WINGSUIT: "Wingsuit",
		TYPE_TRACKING: "Tracking",
	]
	
	static func getTypesForSelect() -> [String] {
		var res = [String]()
		
		for type in types {
			res.append(type.value)
		}
		
		return res
	}
	
	override func getSyncEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
		
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getSuits()
	}
	
	override func getSyncIdentifier() -> String {
		fatalError("not implemented")
	}
	
	override class func build(json: JSON) -> Suit {
		let suit = Suit()
			
		suit.id = json["remote_id"].intValue as NSNumber!
		suit.manufacturer = json["manufacturer"].stringValue
		suit.model = json["model"].stringValue
		suit.serial = json["serial"].stringValue
		suit.type = json["type"].intValue as NSNumber
		
		if !json["date_in_use"].isEmpty {
			suit.date_in_use = DateHelper.stringToDate(string: json["date_in_use"].stringValue)
		}

		return suit

	}
	
	func getFormattedType() -> String? {
		return Suit.types[(self.type?.intValue)!]!
	}
	
	

}
