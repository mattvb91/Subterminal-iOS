//
//  JumpForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 01/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

class JumpForm: Form {
	
	public static let NOTIFICATION_NAME = "jump_data_changed"
	
	override func viewDidLoad() {
		self.formView = JumpFormView.newAutoLayout()
		super.viewDidLoad()
		
		self.navigationItem.title = "Edit Jump"
		
		if getItem().id != nil {
			self.getFormView().date.text = DateHelper.dateToString(date: self.getItem().date!)
			self.getFormView().exitId = getItem().exit()?.id as Int?
			self.getFormView().exit.text = getItem().exit()?.name
			self.getFormView().jumpDescription.text = getItem().jump_description
			self.getFormView().delay.text = getItem().delay?.description
			self.getFormView().pc.text = getItem().pc_size?.description

			self.getFormView().typeDropdown.selectRowForDataSourceWithKey(key: Int(getItem().type!), data: Jump.jump_type, label: getFormView().type)
			self.getFormView().sliderDropdown.selectRowForDataSourceWithKey(key: Int(getItem().slider!), data: Jump.slider_config, label: getFormView().slider)
		} else {
			self.getFormView().typeDropdown.selectRowForDataSourceWithKey(key: Jump.TYPE_SLICK, data: Jump.jump_type, label: getFormView().type)
			self.getFormView().sliderDropdown.selectRowForDataSourceWithKey(key: Jump.SLIDER_UP, data: Jump.slider_config, label: getFormView().slider)
		}
		
		self.view.addSubview(getFormView())
	}
	
	override func initFormValidation() {
		self.validator.addRequiredField(field: self.getFormView().exit)
	}
	
	override func assignFormToEntity() {
		
		if getFormView().exitId != nil {
			self.getItem().exit_id = NSNumber(value: getFormView().exitId!)
		}
		
		self.getItem().type = NSNumber(value: getFormView().typeDropdown.getKeyForDataFromSelectedRow(data: Jump.jump_type)!)
		self.getItem().pc_size = NSNumber(value: Int(self.getFormView().pcDropdown.selectedItem!)!)
		self.getItem().slider = NSNumber(value: getFormView().sliderDropdown.getKeyForDataFromSelectedRow(data: Jump.slider_config)!)
		
		self.getItem().date = DateHelper.stringToDate(string: getFormView().date.text!)
		
		if getFormView().delay.text?.isEmpty == false {
			self.getItem().delay = NSNumber(value: Int(getFormView().delay.text!)!)
		}
		
		self.getItem().jump_description = getFormView().jumpDescription.text
	}
	
	override func getItem() -> Jump {
		return (super.getItem() as? Jump)!
	}
	
	override func getFormView() -> JumpFormView {
		return (super.getFormView() as? JumpFormView)!
	}
	
	override func getNotificationName() -> String {
		return JumpForm.NOTIFICATION_NAME
	}

}
