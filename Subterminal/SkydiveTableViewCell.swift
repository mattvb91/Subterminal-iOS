//
//  SkydiveTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveTableViewCell: BaseTableCell {
	
	var dropzone = UILabel()
	var aircraft = UILabel()
	var delay = UILabel()
	
	var timeAgo = UILabel()
	
	var aircraftLabel = Label(text: "Aircraft:")
	var delayLabel = Label(text: "Delay:")
	
	override func addSubviews() {
		self.contentView.addSubview(dropzone)
		self.contentView.addSubview(aircraft)
		self.contentView.addSubview(delay)
		self.contentView.addSubview(aircraftLabel)
		self.contentView.addSubview(delayLabel)
		self.contentView.addSubview(timeAgo)
		
		dropzone.font = UIFont.boldSystemFont(ofSize: 16)
		
		aircraftLabel.font = UIFont.systemFont(ofSize: 14)
		aircraft.font = UIFont.systemFont(ofSize: 14)
		
		delayLabel.font = UIFont.systemFont(ofSize: 14)
		delay.font = UIFont.systemFont(ofSize: 14)
		
		timeAgo.font = UIFont.systemFont(ofSize: 14)
	}
	
	override func setupConstraints() {
		dropzone.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
		dropzone.autoPinEdge(.top, to: .top, of: self, withOffset: 5)
		
		aircraftLabel.autoPinEdge(.top, to: .bottom, of: dropzone, withOffset: 8)
		aircraftLabel.autoPinEdge(.left, to: .left, of: dropzone)
		
		aircraft.autoPinEdge(.left, to: .right, of: aircraftLabel, withOffset: 10)
		aircraft.autoPinEdge(.top, to: .top, of: aircraftLabel)
		
		delayLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
		delayLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 2)
		
		delay.autoPinEdge(.left, to: .left, of: aircraft)
		delay.autoPinEdge(.top, to: .top, of: delayLabel)
		
		timeAgo.autoPinEdge(.top, to: .top, of: delay)
		timeAgo.autoPinEdge(.right, to: .right, of: self.contentView, withOffset: -20)
	}

}
