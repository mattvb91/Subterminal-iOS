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
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		circle.layer.cornerRadius = self.frame.size.width / 2
		circle.backgroundColor = UIColor.gray
		circle.clipsToBounds = true
		
		self.addSubview(circle)
		
		self.layoutIfNeeded()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setSyncedStatus(status: NSNumber) {
		if status == Synchronizable.SYNC_COMPLETED {
			circle.backgroundColor = UIColor.green
		}
	}
}
