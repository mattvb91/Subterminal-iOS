//
//  GearFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 14/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class GearFormView: UIView {
	
	var didSetupConstraints: Bool = false
	
	//MARK: Properties
	var containerManufacturer: UITextField!
	var containerModel: UITextField!
	var containerSerial: UITextField!
	var containerDateInUse: UITextField!

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
