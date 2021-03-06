//
//  Model.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SharkORM

class Model: SRKObject {
    
    //Wrapper for commit
    open func save() -> Bool {
        return super.commit()
    }
	
	//Use this for subscribing to update events
	class func getNotificationName() -> String {
		return NSStringFromClass(self) + "_notification"
	}
	
	func sendModelNotification() {
		let notificationName = type(of: self).getNotificationName()
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName), object: nil)
	}
}
