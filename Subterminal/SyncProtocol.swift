//
//  SyncProtocol.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 22/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//
//

import Foundation
import Alamofire
import SwiftyJSON

//Implement protocol for model synchronization
protocol SyncProtocol {
	
	func getSyncEndpoint() -> URLRequestConvertible
	
	func getDeleteEndpoint() -> URLRequestConvertible
	
	func getDownloadEndpoint() -> URLRequestConvertible
	
	func getSyncIdentifier() -> String
	
	static func build(json: JSON) -> Synchronizable
	
}
