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
	
	var thumb = UIImageView()
	var synced = SyncIcon()

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
		self.contentView.addSubview(thumb)
		self.contentView.addSubview(synced)
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
			exitName.autoPinEdge(.left, to: .right, of: thumb, withOffset: 10)
		} else {
			exitName.autoPinEdge(.left, to: .right, of: count, withOffset: 10)
		}

		exitName.autoPinEdge(.top, to: .top, of: self, withOffset: 5)
		
		delay.autoPinEdge(.top, to: .bottom, of: exitName, withOffset: 5)
		delay.autoPinEdge(.left, to: .left, of: exitName)
		
		slider.autoPinEdge(.top, to: .bottom, of: delay, withOffset: 5)
		slider.autoPinEdge(.left, to: .left, of: exitName)
		
		timeAgo.autoPinEdge(.right, to: .right, of: self, withOffset: -20)
		timeAgo.autoPinEdge(.top, to: .top, of: exitName)
		
		synced.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -15)
		synced.autoPinEdge(.right, to: .right, of: self.contentView, withOffset: -20)
	}
}
