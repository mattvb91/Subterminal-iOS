//
//  SuitForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 26/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

class SuitForm: Form {
	
	public static let NOTIFICATION_NAME = "gear_data_changed"
	
	override func viewDidLoad() {
		super.viewDidLoad()
				
		self.formView = SuitFormView.newAutoLayout()
		
		if getItem().id != nil {
			getFormView().manufacturer.text = getItem().manufacturer
			getFormView().model.text = getItem().model
			getFormView().serial.text = getItem().serial
			
			if getItem().date_in_use != nil {
				getFormView().dateField.text = DateHelper.dateToString(date: getItem().date_in_use!)
				getFormView().datePicker.config.startDate = getItem().date_in_use
			}
		}
		
		self.view.addSubview(getFormView())
	}
	
	override func getItem() -> Suit {
		return (super.getItem() as? Suit)!
	}
	
	override func formIsValid() -> Bool {
		return true
	}
	
	override func assignFormToEntity() {
		getItem().model = getFormView().model.text
		getItem().manufacturer = getFormView().manufacturer.text
		getItem().serial = getFormView().serial.text
		getItem().date_in_use = DateHelper.stringToDate(string: getFormView().dateField.text!)
	}
	
	override func getFormView() -> SuitFormView {
		return super.getFormView() as! SuitFormView
	}
	
	override func getNotificationName() -> String {
		return GearForm.NOTIFICATION_NAME
	}
}