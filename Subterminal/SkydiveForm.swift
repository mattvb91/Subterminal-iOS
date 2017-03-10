//
//  SkydiveFormController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveForm: Form {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.formView = SkydiveFormView.newAutoLayout()
		self.navigationItem.title = "Edit Skydive"
		
		if getItem().id != nil {
			
			if getItem().dropzone_id != nil {
				getFormView().dropzoneId = Int(getItem().dropzone_id!)
				getFormView().dropzone.text = getItem().dropzone()?.name
			}
			
			getFormView().dateSelectedLabel.text = DateHelper.dateToString(date: getItem().date!)
			
			if getItem().aircraft_id != nil {
				getFormView().aircraft.selectRowForDataSourceWithKey(key: Int(getItem().aircraft_id!), data: Aircraft.getAircrafts(), label: getFormView().aircraftSelectedLabel)
			}
			
			getFormView().exitAlt.text = getItem().exit_altitude?.description
			getFormView().deployAlt.text = getItem().deploy_altidude?.description
			getFormView().cutaway.isOn = Bool(getItem().cutaway)
			getFormView().delay.text = getItem().delay?.description
			getFormView().descriptionInput.text = getItem().skydive_description
			getFormView().type.selectRowForDataSourceWithKey(key: Int(getItem().jump_type!), data: Skydive.types, label: getFormView().typeSelectedLabel)
			getFormView().heightUnit.selectedSegmentIndex = Int(getItem().height_unit)
			
			if getItem().rig_id != nil {
				getFormView().rig.selectRowForDataSourceWithKey(key: Int(getItem().rig_id!), data: Rig.getRigs(), label: getFormView().rigSelectedLabel)
			}
			
		} else {
			getFormView().type.selectRowForDataSourceWithKey(key: Skydive.SKYDIVE_TYPE_BELLY, data: Skydive.types, label: getFormView().typeSelectedLabel)
			getFormView().heightUnit.selectedSegmentIndex = Subterminal.heightUnit
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
		
		if getFormView().aircraft.indexForSelectedRow != nil {
			getItem().aircraft_id = getFormView().aircraft.getKeyForDataFromSelectedRow(data: Aircraft.getAircrafts()) as NSNumber?
		}
		
		if getFormView().dropzoneId != nil {
			getItem().dropzone_id = NSNumber(value: getFormView().dropzoneId!)
		}
		
		if getFormView().type.indexForSelectedRow != nil {
			let selectedType = getFormView().type.indexForSelectedRow
			let type = Skydive.getKeysForTypes()[selectedType!]
			
			getItem().jump_type = NSNumber(value: type)
		}
		
		if getFormView().rig.indexForSelectedRow != nil && getFormView().rig.selectedItem != " - " {
			getItem().rig_id = getFormView().rig.parseIdFromSelection() as NSNumber?
		} else {
			getItem().rig_id = nil
		}
		
		getItem().height_unit = getFormView().heightUnit.selectedSegmentIndex as! NSNumber
	
		getItem().cutaway = getFormView().cutaway.isOn ? 1 : 0
		
		let date = DateHelper.stringToDate(string: getFormView().dateSelectedLabel.text!)
		
		getItem().date = date
	}
	
	override func getItem() -> Skydive {
		return (super.getItem() as? Skydive)!
	}
	
	override func getFormView() -> SkydiveFormView {
		return (super.getFormView() as? SkydiveFormView)!
	}
}
