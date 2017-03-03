//
//  HeightUnitView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 02/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class HeightUnitView: UIView {
	
	var heightUnit: Int = Subterminal.heightUnit
	var didSetupConstraints: Bool = false
	var segment: UISegmentedControl = UISegmentedControl(items: ["Metric (m)", "Imperial (ft)"])

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		segment.selectedSegmentIndex = Subterminal.heightUnit
		segment.sizeToFit()
		segment.tintColor = self.tintColor
		
		self.addSubview(segment)
	}


	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

}
