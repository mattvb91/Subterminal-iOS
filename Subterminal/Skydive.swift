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
    var skydive_description: String = ""
    var date: Date?
    
    var dropzone_id,
        exit_altitude,
        deploy_altidude,
        delay,
        jump_type,
        aircraft_id,
        rig_id,
        suid_id: Int?
    
    var height_unit: Int = 0

}
