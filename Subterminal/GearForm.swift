//
//  GearForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import os.log

class GearForm: Form {
	
	public static let NOTIFICATION_NAME = "gear_data_changed"
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.formView = GearFormView.newAutoLayout()
		
		if getItem().id != nil {
			getFormView().containerManufacturer.text = getItem().container_manufacturer
			getFormView().containerModel.text = getItem().container_model
			getFormView().containerSerial.text = getItem().container_serial
			getFormView().containerDateInUse.text = getItem().container_date_in_use
		}
		
		self.view.addSubview(getFormView())
    }
	
	override func getItem() -> Rig {
		return (super.getItem() as? Rig)!
	}
	
	override func formIsValid() -> Bool {
		return true
	}
	
	override func assignFormToEntity() {
		getItem().container_manufacturer = self.getFormView().containerManufacturer.text
		getItem().container_model = self.getFormView().containerModel.text
		getItem().container_serial = self.getFormView().containerSerial.text
	}
	
	override func getFormView() -> GearFormView {
		return super.getFormView() as! GearFormView
	}
	
	override func getNotificationName() -> String {
		return GearForm.NOTIFICATION_NAME
	}
}
