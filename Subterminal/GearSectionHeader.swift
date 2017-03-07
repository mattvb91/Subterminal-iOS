//
//  GearSectionHeader.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 06/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class GearSectionHeader: UITableViewHeaderFooterView {
	
	var sectionName = UILabel()
	var button = UIButton()
	
	var didSetupConstraints: Bool = false
	
	override func init(reuseIdentifier: String?)
		super.ini
		self.backgroundColor = UIColor.lightGray
		
		self.addSubview(sectionName)
		self.addSubview(button)
		
		setNeedsUpdateConstraints()
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			self.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 40))
			
			sectionName.autoPinEdge(.left, to: .left, of: self.superview!, withOffset: 20)
			sectionName.autoPinEdge(.top, to: .top, of: self.superview!, withOffset: 15)
			
			button.autoPinEdge(.right, to: .right, of: self.superview!, withOffset: -20)
			button.autoPinEdge(.top, to: .top, of: sectionName)
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
