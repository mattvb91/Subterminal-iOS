//
//  ChoiceTableViewCell.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 20/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import Bohr

class ChoiceTableViewCell: BOChoiceTableViewCell {
	
	var keyValueOptions: [Int: String]!
	
	override open func settingValueDidChange() -> Void {
		self.detailTextLabel?.text = self.keyValueOptions[self.setting.value as! Int]
	}
}
