//
//  TunnelTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 05/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class TunnelTableViewCell: BaseTableCell {
	
	var name = UILabel()
	var country = UILabel()
	
	override func addSubviews() {
		name.font = UIFont.boldSystemFont(ofSize: 16)
		
		self.contentView.addSubview(name)
		self.contentView.addSubview(country)
	}
	
	override func setupConstraints() {
		name.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
		name.autoPinEdge(.top, to: .top, of: self.contentView, withOffset: 10)
		
		country.autoPinEdge(.top, to: .bottom, of: name, withOffset: 10)
		country.autoPinEdge(.left, to: .left, of: name)
	}
}
