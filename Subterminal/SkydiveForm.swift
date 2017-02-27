//
//  SkydiveFormController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveForm: Form {

	public static let NOTIFICATION_NAME = "skydive_data_changed"

    override func viewDidLoad() {
        super.viewDidLoad()

		self.formView = SkydiveFormView.newAutoLayout()
		
		if getItem().id != nil {
			
			if getItem().dropzone_id != nil {
				getFormView().dropzoneId = Int(getItem().dropzone_id!)
				getFormView().dropzone.text = getItem().dropzone()?.name
			}
			
			getFormView().dateSelectedLabel.text = DateHelper.dateToString(date: getItem().date!)
			getFormView().aircraftSelectedLabel.text = getItem().aircraft()?.name
			getFormView().typeLabel.text = getItem().getFormattedType()
			getFormView().exitAlt.text = getItem().exit_altitude?.description
			getFormView().deployAlt.text = getItem().deploy_altidude?.description
			getFormView().delay.text = getItem().delay?.description
			getFormView().descriptionInput.text = getItem().skydive_description
		}
		
		self.view.addSubview(self.formView!)
    }
	
	override func formIsValid() -> Bool {
		return true
	}
	
	override func assignFormToEntity() {
		
		if getFormView().delay.text?.isEmpty == false {
			getItem().delay = NSNumber(value: Int(getFormView().delay.text!)!)
		}
		
		if getFormView().exitAlt.text?.isEmpty == false {
			getItem().exit_altitude = NSNumber(value: Int(getFormView().exitAlt.text!)!)
		}
		
		if getFormView().deployAlt.text?.isEmpty == false {
			getItem().deploy_altidude = NSNumber(value: Int(getFormView().deployAlt.text!)!)
		}
		
		getItem().skydive_description = getFormView().descriptionInput.text
		
		let aircraft = getFormView().aircraft.selectedItem
		let aircraftDB = Aircraft.query().where(withFormat: "name = %@", withParameters: [aircraft]).fetch().firstObject as? Aircraft
		getItem().aircraft_id = aircraftDB?.id
		
		if getFormView().dropzoneId != nil {
			getItem().dropzone_id = NSNumber(value: getFormView().dropzoneId!)
		}
		
		if getFormView().type.indexForSelectedRow != nil {
			let selectedType = getFormView().type.indexForSelectedRow
			let type = Skydive.getKeysForTypes()[selectedType!]
			
			getItem().jump_type = NSNumber(value: type)
		}
		
		if getFormView().cutaway.isOn {
			getItem().cutaway = 1
		}
		
		let date = DateHelper.stringToDate(string: getFormView().dateSelectedLabel.text!)
		
		getItem().date = date
	}
	
	override func getItem() -> Skydive {
		return (super.getItem() as? Skydive)!
	}
	
	override func getFormView() -> SkydiveFormView {
		return (super.getFormView() as? SkydiveFormView)!
	}
	
	override func getNotificationName() -> String {
		return SkydiveForm.NOTIFICATION_NAME
	}
}
