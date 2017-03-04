//
//  ExitDetails.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 27/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExitDetails: Model {
	
	dynamic var exit_id,
		difficulty_tracking_exit,
		difficulty_tracking_freefall,
		difficulty_tracking_landing,
		difficulty_tracking_overall,
		difficulty_wingsuit_exit,
		difficulty_wingsuit_freefall,
		difficulty_wingsuit_landing,
		difficulty_wingsuit_overall: NSNumber!
	
	dynamic var rules: String!
	
	class func build(json: JSON) -> ExitDetails {
		let details = ExitDetails()
		
		details.difficulty_tracking_exit = json["difficulty_tracking_exit"].number
		details.difficulty_tracking_freefall = json["difficulty_tracking_freefall"].number
		details.difficulty_tracking_landing = json["difficulty_tracking_landing"].number
		details.difficulty_tracking_overall = json["difficulty_tracking_overall"].number
		details.difficulty_wingsuit_exit = json["difficulty_wingsuit_exit"].number
		details.difficulty_wingsuit_freefall = json["difficulty_wingsuit_freefall"].number
		details.difficulty_wingsuit_landing = json["difficulty_wingsuit_landing"].number
		details.difficulty_wingsuit_overall = json["difficulty_wingsuit_overall"].number
		details.rules = json["rules"].string

		return details
	}
	
	func equals(details: ExitDetails) -> Bool {
		return self.exit_id == details.exit_id &&
		self.difficulty_tracking_exit == details.difficulty_tracking_exit &&
		self.difficulty_tracking_freefall == details.difficulty_tracking_freefall &&
		self.difficulty_tracking_landing == details.difficulty_tracking_landing &&
		self.difficulty_tracking_overall == details.difficulty_tracking_overall &&
		self.difficulty_wingsuit_exit == details.difficulty_wingsuit_exit &&
		self.difficulty_wingsuit_freefall == details.difficulty_wingsuit_freefall &&
		self.difficulty_wingsuit_landing == details.difficulty_wingsuit_landing &&
		self.difficulty_wingsuit_overall == details.difficulty_wingsuit_overall &&
		self.rules == details.rules
	}
}
