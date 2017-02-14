//
//  BaseTableCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 14/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {

	var didSetupConstraints: Bool = false
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		addSubviews()
		
		self.setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	/*
	 * Add all views into the cell
	 */
	func addSubviews() {
		fatalError("addSubviews() not implemented")
	}
	
	func setupConstraints() {
		fatalError("setupConstraints() not implemented")
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			setupConstraints()
		}
		
		super.updateConstraints()
	}
}
