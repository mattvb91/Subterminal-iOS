//
//  DropzoneTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 12/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class DropzoneTableViewCell: BaseTableCell {

	var nameLabel = UILabel()
	var countryLabel = UILabel()
	var aircraftLabel = UILabel()
	
	override func addSubviews() {
		nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
		countryLabel.font = UIFont.systemFont(ofSize: 12)
		aircraftLabel.font = UIFont.systemFont(ofSize: 12)
		
		self.contentView.addSubview(nameLabel)
		self.contentView.addSubview(countryLabel)
		self.contentView.addSubview(aircraftLabel)
	}
	
	override func setupConstraints() {
		nameLabel.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
		nameLabel.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
		countryLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 10)
		countryLabel.autoPinEdge(.left, to: .left, of: nameLabel)
		
		aircraftLabel.autoPinEdge(.top, to: .top, of: countryLabel)
		aircraftLabel.autoPinEdge(.right, to: .right, of: self, withOffset: -10)
	}
}
