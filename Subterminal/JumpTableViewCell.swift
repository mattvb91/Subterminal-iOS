//
//  JumpTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import PureLayout

class JumpTableViewCell: BaseTableCell {
	
	var exitName = UILabel()
	var delay = UILabel()
	var slider = UILabel()
	
	var count = UILabel()
	var timeAgo = UILabel()
	
	override func addSubviews() {
		
		count.font = UIFont.boldSystemFont(ofSize: 24)
		
		exitName.font = UIFont.boldSystemFont(ofSize: 16)
		delay.font = UIFont.systemFont(ofSize: 12)
		slider.font = UIFont.systemFont(ofSize: 12)
		timeAgo.font = UIFont.boldSystemFont(ofSize: 12)

		self.contentView.addSubview(count)
		self.contentView.addSubview(exitName)
		self.contentView.addSubview(delay)
		self.contentView.addSubview(slider)
		self.contentView.addSubview(timeAgo)
	}
	
	override func setupConstraints() {
		count.autoPinEdge(.left, to: .left, of: self, withOffset: 10)
		count.autoPinEdge(.top, to: .top, of: self, withOffset: 25)
		
		exitName.autoPinEdge(.top, to: .top, of: self, withOffset: 5)
		exitName.autoPinEdge(.left, to: .right, of: count, withOffset: 10)
		
		delay.autoPinEdge(.top, to: .bottom, of: exitName, withOffset: 5)
		delay.autoPinEdge(.left, to: .left, of: exitName)
		
		slider.autoPinEdge(.top, to: .bottom, of: delay, withOffset: 5)
		slider.autoPinEdge(.left, to: .left, of: exitName)
		
		timeAgo.autoPinEdge(.right, to: .right, of: self, withOffset: -20)
		timeAgo.autoPinEdge(.top, to: .top, of: exitName)
	}
}
