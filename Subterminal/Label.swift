//
//  Label.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 16/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class Label: UILabel {

	convenience init(text: String) {
		self.init()
		
		self.text = text
		self.textColor = UIColor.gray
	}
}

