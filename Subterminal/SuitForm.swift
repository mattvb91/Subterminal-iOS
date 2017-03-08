//
//  SuitForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 26/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

class SuitForm: Form {
	
	override func viewDidLoad() {
		self.formView = SuitFormView.newAutoLayout()

		super.viewDidLoad()
				
		self.navigationItem.title = "Edit Suit"
		
		if getItem().id != nil {
			getFormView().manufacturer.text = getItem().manufacturer
			getFormView().model.text = getItem().model
			getFormView().serial.text = getItem().serial
			
			if getItem().date_in_use != nil {
				getFormView().dateField.text = DateHelper.dateToString(date: getItem().date_in_use!)
				getFormView().datePicker.config.startDate = getItem().date_in_use
			}
			
			getFormView().typeDropdown.selectRowForDataSourceWithKey(key: Int(getItem().type!), data: Suit.types, label: getFormView().type)
		} else {
			getFormView().typeDropdown.selectRowForDataSourceWithKey(key: Suit.TYPE_TRACKING, data: Suit.types, label: getFormView().type)
		}
		
		self.view.addSubview(getFormView())
	}
	
	override func initFormValidation() {
		self.validator.addRequiredField(field: self.getFormView().manufacturer)
	}
	
	override func getItem() -> Suit {
		return (super.getItem() as? Suit)!
	}
	
	override func assignFormToEntity() {
		getItem().model = getFormView().model.text
		getItem().manufacturer = getFormView().manufacturer.text
		getItem().serial = getFormView().serial.text
		getItem().date_in_use = DateHelper.stringToDate(string: getFormView().dateField.text!)
		getItem().type = NSNumber(value: getFormView().typeDropdown.getKeyForDataFromSelectedRow(data: Suit.types)!)
	}
	
	override func getFormView() -> SuitFormView {
		return super.getFormView() as! SuitFormView
	}
}
