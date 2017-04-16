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
import SharkORM

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
		return Router.syncSuit(model: self)
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
		
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getSuits()
	}
	
	override func getSyncIdentifier() -> String {
		return "SYNC_SUIT"
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
	
	override func toJSON() -> [String : Any] {
		var values = [
			"manufacturer": manufacturer,
			"model": model,
			"serial": serial,
			"type": type,
			"date_in_use": DateHelper.dateToString(date: date_in_use!)
			] as [String: Any]
		
		values.merge(other: super.toJSON())
		
		return values
	}
	
	func getFormattedType() -> String? {
		return Suit.types[(self.type?.intValue)!]!
	}
	
	//Return all available suits for
	static func getOptionsForSelect(type: Int) -> [String] {
		let suits = Suit.query().where(withFormat: "type = %@", withParameters: [type]).fetch() as SRKResultSet
		
		var res = [String]()
		for suit in suits {
			let suit = suit as! Suit
			let viewString = suit.manufacturer! + " / " + suit.model!
			res.append(suit.id.description + " - " + viewString)
		}

		return res
	}
	

}
