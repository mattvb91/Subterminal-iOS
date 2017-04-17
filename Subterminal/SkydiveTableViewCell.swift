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
	var count = UILabel()

	var timeAgo = UILabel()
	
	var synced = SyncIcon()
	
	var aircraftLabel = Label(text: "Aircraft:")
	var delayLabel = Label(text: "Delay:")
	
	var thumb = UIImageView()
	
	override func addSubviews() {
		
		count.font = UIFont.boldSystemFont(ofSize: 24)

		self.contentView.addSubview(count)
		self.contentView.addSubview(dropzone)
		self.contentView.addSubview(aircraft)
		self.contentView.addSubview(delay)
		self.contentView.addSubview(aircraftLabel)
		self.contentView.addSubview(delayLabel)
		self.contentView.addSubview(timeAgo)
		self.contentView.addSubview(thumb)
		self.contentView.addSubview(synced)

		dropzone.font = UIFont.boldSystemFont(ofSize: 16)
		
		aircraftLabel.font = UIFont.systemFont(ofSize: 14)
		aircraft.font = UIFont.systemFont(ofSize: 14)
		
		delayLabel.font = UIFont.systemFont(ofSize: 14)
		delay.font = UIFont.systemFont(ofSize: 14)
		
		timeAgo.font = UIFont.systemFont(ofSize: 14)
	}
	
	override func prepareForReuse() {
		thumb.image = nil
		super.prepareForReuse()
	}
	
	override func setupConstraints() {

		count.autoPinEdge(.left, to: .left, of: self, withOffset: 10)
		count.autoPinEdge(.top, to: .top, of: self, withOffset: 25)
		
		if thumb.image != nil {
			thumb.autoSetDimensions(to: CGSize(width: 50, height: 50))
			thumb.autoPinEdge(.left, to: .right, of: count, withOffset: 5)
			thumb.autoPinEdge(.top, to: .top, of: self, withOffset: 15)
			dropzone.autoPinEdge(.left, to: .right, of: thumb, withOffset: 10)
		} else {
			dropzone.autoPinEdge(.left, to: .right, of: count, withOffset: 20)
		}
		dropzone.autoPinEdge(.top, to: .top, of: self, withOffset: 5)
		
		aircraftLabel.autoPinEdge(.top, to: .bottom, of: dropzone, withOffset: 8)
		aircraftLabel.autoPinEdge(.left, to: .left, of: dropzone)
		
		aircraft.autoPinEdge(.left, to: .right, of: aircraftLabel, withOffset: 10)
		aircraft.autoPinEdge(.top, to: .top, of: aircraftLabel)
		
		delayLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
		delayLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 2)
		
		delay.autoPinEdge(.left, to: .left, of: aircraft)
		delay.autoPinEdge(.top, to: .top, of: delayLabel)
		
		timeAgo.autoPinEdge(.top, to: .top, of: dropzone)
		timeAgo.autoPinEdge(.right, to: .right, of: self.contentView, withOffset: -20)
		
		synced.autoPinEdge(.bottom, to: .bottom, of: delay)
		synced.autoPinEdge(.right, to: .right, of: timeAgo)
	}

}
