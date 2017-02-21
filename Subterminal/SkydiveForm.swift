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
		self.view.addSubview(self.formView!)
    }
	
	override func formIsValid() -> Bool {
		return true
	}
	
	override func assignFormToEntity() {
		getItem().delay = NSNumber(value: Int(getFormView().delay.text!)!)
		getItem().exit_altitude = NSNumber(value: Int(getFormView().exitAlt.text!)!)
		getItem().deploy_altidude = NSNumber(value: Int(getFormView().deployAlt.text!)!)
		getItem().skydive_description = getFormView().descriptionInput.text
		
		let aircraft = getFormView().aircraft.selectedItem
		let aircraftDB = Aircraft.query().where(withFormat: "name = %@", withParameters: [aircraft]).fetch().firstObject as? Aircraft
		getItem().aircraft_id = aircraftDB?.id
		
		if getFormView().type.indexForSelectedRow != nil {
			let selectedType = getFormView().type.indexForSelectedRow
			let type = Skydive.getKeysForTypes()[selectedType!]
			
			getItem().jump_type = NSNumber(value: type)
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
