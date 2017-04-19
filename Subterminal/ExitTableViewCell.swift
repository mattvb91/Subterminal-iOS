//
//  ExitTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 27/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class ExitTableViewCell: BaseTableCell {
	
	var objectType = UILabel()
	var name = UILabel()
	var height = UILabel()
	var time = UILabel()
	
	var synced = SyncIcon()

	override func addSubviews() {
		objectType.font = UIFont.boldSystemFont(ofSize: 14)
		name.font = UIFont.boldSystemFont(ofSize: 16)
		height.font = UIFont.systemFont(ofSize: 14)
		time.font = UIFont.systemFont(ofSize: 14)

		self.contentView.addSubview(objectType)
		self.contentView.addSubview(name)
		self.contentView.addSubview(height)
		self.contentView.addSubview(time)
		self.contentView.addSubview(synced)
	}
	
	override func setupConstraints() {
		name.autoPinEdge(.top, to: .top, of: self, withOffset: 10)
		name.autoPinEdge(.left, to: .left, of: self, withOffset: 20)
		
		height.autoPinEdge(.left, to: .left, of: name)
		height.autoPinEdge(.top, to: .bottom, of: name, withOffset: 8)
		
		objectType.autoPinEdge(.top, to: .top, of: name)
		objectType.autoPinEdge(.right, to: .right, of: self, withOffset: -20)
		
		time.autoPinEdge(.top, to: .bottom, of: height, withOffset: 5)
		time.autoPinEdge(.left, to: .left, of: height)
		
		synced.autoPinEdge(.bottom, to: .bottom, of: self.contentView, withOffset: -15)
		synced.autoPinEdge(.right, to: .right, of: self.contentView, withOffset: -20)
	}
}
