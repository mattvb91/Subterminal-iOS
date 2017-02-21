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
			
			getFormView().mainManufacturer.text = getItem().main_manufacturer
			getFormView().mainModel.text = getItem().main_model
			getFormView().mainSerial.text = getItem().main_serial
			getFormView().mainDateInUse.text = getItem().main_date_in_use

			getFormView().reserveManufacturer.text = getItem().reserve_manufacturer
			getFormView().reserveModel.text = getItem().reserve_model
			getFormView().reserveSerial.text = getItem().reserve_serial
			getFormView().reserveDateInUse.text = getItem().reserve_date_in_use
			
			getFormView().aadManufacturer.text = getItem().aad_manufacturer
			getFormView().aadModel.text = getItem().aad_model
			getFormView().aadSerial.text = getItem().aad_serial
			getFormView().aadDateInUse.text = getItem().aad_date_in_use
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
		
		getItem().main_manufacturer = self.getFormView().mainManufacturer.text
		getItem().main_model = self.getFormView().mainModel.text
		getItem().main_serial = self.getFormView().mainSerial.text
		
		getItem().reserve_manufacturer = self.getFormView().reserveManufacturer.text
		getItem().reserve_model = self.getFormView().reserveModel.text
		getItem().reserve_serial = self.getFormView().reserveSerial.text
		
		getItem().aad_manufacturer = self.getFormView().aadManufacturer.text
		getItem().aad_model = self.getFormView().aadModel.text
		getItem().aad_serial = self.getFormView().aadSerial.text
	}
	
	override func getFormView() -> GearFormView {
		return super.getFormView() as! GearFormView
	}
	
	override func getNotificationName() -> String {
		return GearForm.NOTIFICATION_NAME
	}
}
