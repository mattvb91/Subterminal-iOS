//
//  FormValidator.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 07/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class FormValidator {
	
	var requiredFields = [UITextField]()
	var valid: Bool = true
	
	func addRequiredField(field: UITextField) {
		self.requiredFields.append(field)
	}
	
	func validate() {
		self.valid = true
		
		for field in self.requiredFields {
			if field.text?.characters.count == 0 {
				self.valid = false
				
				field.layer.shadowColor = UIColor.red.cgColor
			}
		}
	}
	
	func isValid() -> Bool {
		self.validate()
		
		return self.valid
	}
}
