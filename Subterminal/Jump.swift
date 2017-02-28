//
//  Jump.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Jump: Synchronizable {
	
	dynamic var jump_description: String?
	dynamic var date: Date?
	
	dynamic var gear_id,
		delay,
		exit_id,
		type,
		suit_id,
		pc_size,
		slider: NSNumber?
	
	static let SLIDER_DOWN = 0
	static let SLIDER_UP = 1
	static let SLIDER_OFF = 2
	
	static var slider_config = [
		SLIDER_DOWN: "Down",
		SLIDER_UP: "Up",
		SLIDER_OFF: "Off"
	]
	
	func getFormattedSlider() -> String? {
		if self.slider != nil {
			return Jump.slider_config[(self.slider?.intValue)!]!
		}
		
		return nil
	}
	
	static let pc_sizes = [32, 36, 38, 40, 42, 46, 48]
	
	override func getSyncEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
	}
	
	override func getDeleteEndpoint() -> URLRequestConvertible {
		fatalError("not implemented")
		
	}
	
	override func getDownloadEndpoint() -> URLRequestConvertible {
		return Router.getJumps()
	}
	
	override func getSyncIdentifier() -> String {
		fatalError("not implemented")
	}
	
	override class func build(json: JSON) -> Synchronizable {
		fatalError("not implemented")
	}
	
	
	override class func build(json: JSON) -> Jump {
		let jump = Jump()
		
		jump.id = json["remote_id"].number
		jump.jump_description = json["description"].string
		jump.date = DateHelper.stringToDate(string: json["date"].string!)
		jump.gear_id = json["gear_id"].number
		jump.exit_id = json["exit_id"].number
		jump.delay = json["delay"].number
		jump.type = json["type"].number
		jump.suit_id = json["suit_id"].number
		jump.pc_size = json["pc_size"].number
		jump.slider = json["slider"].number

		return jump

	}
	
	func exit() -> Exit? {
		if self.exit_id != nil {
			return Exit.object(withPrimaryKeyValue: self.exit_id) as! Exit
		}
		
		return nil
	}

}
