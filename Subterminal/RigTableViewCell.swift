//
//  RigTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class RigTableViewCell: BaseTableCell {

	var containerModelLabel = UILabel()
	var containerManufacturerLabel = UILabel()
	
	override func addSubviews() {
		containerManufacturerLabel.font = UIFont.boldSystemFont(ofSize: 16)

		self.contentView.addSubview(containerManufacturerLabel)
		self.contentView.addSubview(containerModelLabel)
	}
	
	override func setupConstraints() {
		containerManufacturerLabel.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
		containerModelLabel.autoPinEdge(.top, to: .bottom, of: containerManufacturerLabel, withOffset: 5)
		containerModelLabel.autoPinEdge(.left, to: .left, of: containerManufacturerLabel)
	}
	
}
