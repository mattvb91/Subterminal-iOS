//
//  RigForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 07/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

class RigForm: Form {
	
	public static let NOTIFICATION_NAME = "rig_data_changed"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.formView = RigFormView.newAutoLayout()
		
		if getItem().id != nil {
			getFormView().containerModel.text = self.getItem().container_type
			getFormView().containerManufacturer.text = self.getItem().container_manufacturer
			getFormView().containerSerial.text = self.getItem().container_serial
			
			if getItem().container_date_in_use != nil {
				getFormView().containerDateInUse.text = DateHelper.dateToString(date: getItem().container_date_in_use!)
			}
			
			getFormView().mainManufacturer.text = self.getItem().canopy_manufacturer
			getFormView().mainModel.text = self.getItem().canopy_type
			getFormView().mainSerial.text = self.getItem().canopy_serial
			
			if getItem().canopy_date_in_use != nil {
				getFormView().mainDateInUse.text = DateHelper.dateToString(date: self.getItem().canopy_date_in_use!)
			}
		}

		self.view.addSubview(self.getFormView())
	}
	
	override func formIsValid() -> Bool {
		return true
	}
	
	override func assignFormToEntity() {
		self.getItem().container_type = self.getFormView().containerModel.text
		self.getItem().container_manufacturer = self.getFormView().containerManufacturer.text
		self.getItem().container_serial = self.getFormView().containerSerial.text
		
		if self.getFormView().containerDateInUse.text?.isEmpty == false {
			self.getItem().container_date_in_use = DateHelper.stringToDate(string: self.getFormView().containerDateInUse.text!)
		}
		
		self.getItem().canopy_type = self.getFormView().mainModel.text
		self.getItem().canopy_manufacturer = self.getFormView().mainManufacturer.text
		self.getItem().canopy_serial = self.getFormView().mainSerial.text
		
		if self.getFormView().mainDateInUse.text?.isEmpty == false {
			self.getItem().canopy_date_in_use = DateHelper.stringToDate(string: self.getFormView().mainDateInUse.text!)
		}
	}
	
	override func getNotificationName() -> String {
		return RigForm.NOTIFICATION_NAME
	}
	
	override func getItem() -> BASERig {
		return (super.getItem() as? BASERig)!
	}
	
	override func getFormView() -> RigFormView {
		return (super.getFormView() as? RigFormView)!
	}

}
