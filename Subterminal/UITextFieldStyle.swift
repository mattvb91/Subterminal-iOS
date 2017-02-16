//
//  UITextFieldStyle.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 16/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//
// Override some UITextField styling
//

import UIKit

extension UITextField {
	
	func setBottomBorder() {
		self.borderStyle = .none
		self.layer.backgroundColor = UIColor.white.cgColor
		
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.gray.cgColor
		self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
		self.layer.shadowOpacity = 1.0
		self.layer.shadowRadius = 0.0
	}
}
