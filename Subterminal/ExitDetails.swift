//
//  ExitDetails.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 27/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

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
}
