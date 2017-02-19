//
//  Skydive.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

class Skydive: Model {
    
    //MARK: Properties
    dynamic var skydive_description: String?
    dynamic var date: Date?
    
	dynamic var dropzone_id,
		exit_altitude,
        deploy_altidude,
        delay,
        jump_type,
        aircraft_id,
        rig_id,
        suid_id: NSNumber?
	
    dynamic var height_unit: Int = 0

}
