//
//  SyncIcon.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 16/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class SyncIcon: UIView {
	
	var circle = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
	
	static let COLOR_GREY = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
	static let COLOR_GREEN = UIColor(red:0.49, green:1.00, blue:0.49, alpha:1.0)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.layoutIfNeeded()

		circle.layer.cornerRadius = circle.frame.size.width / 2
		circle.backgroundColor = SyncIcon.COLOR_GREY
		circle.clipsToBounds = true
		
		self.addSubview(circle)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setSyncedStatus(status: NSNumber) {
		if status == Synchronizable.SYNC_COMPLETED {
			circle.backgroundColor = SyncIcon.COLOR_GREEN
		} else {
			circle.backgroundColor = SyncIcon.COLOR_GREY
		}
	}
}
