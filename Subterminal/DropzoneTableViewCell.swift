//
//  DropzoneTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 12/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class DropzoneTableViewCell: UITableViewCell {

	var nameLabel = UILabel()
	var countryLabel = UILabel()
	
	var didSetupConstraints: Bool = false

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
		countryLabel.font = UIFont.systemFont(ofSize: 12)
		
		self.contentView.addSubview(nameLabel)
		self.contentView.addSubview(countryLabel)
		
		self.setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			nameLabel.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
			nameLabel.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
			countryLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 10)
			countryLabel.autoPinEdge(.left, to: .left, of: nameLabel)
		}
		
		super.updateConstraints()
	}
	
}
