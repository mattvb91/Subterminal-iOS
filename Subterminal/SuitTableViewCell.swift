//
//  SuitTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 23/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class SuitTableViewCell: BaseTableCell {
	
	var modelLabel = UILabel()
	var manufacturerLabel = UILabel()
	var type = UILabel()
	
	override func addSubviews() {
		type.font = UIFont.boldSystemFont(ofSize: 16)
		
		self.contentView.addSubview(modelLabel)
		self.contentView.addSubview(manufacturerLabel)
		self.contentView.addSubview(type)
	}
	
	override func setupConstraints() {
		type.autoPinEdge(.left, to: .left, of: self, withOffset: 30)
		type.autoPinEdge(.top, to: .top, of: self, withOffset: 20)
		
		manufacturerLabel.autoPinEdge(.left, to: .right, of: type, withOffset: 30)
		manufacturerLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 10)
		
		modelLabel.autoPinEdge(.left, to: .left, of: manufacturerLabel)
		modelLabel.autoPinEdge(.top, to: .bottom, of: manufacturerLabel, withOffset: 5)
	}
}
