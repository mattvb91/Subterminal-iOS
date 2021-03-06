//
//  JumpForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 01/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation

class JumpForm: Form {
	
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
			
			if getItem().gear_id != nil {
				self.getFormView().rigDropdown.selectRowForDataSourceWithKey(key: Int(getItem().gear_id!), data: BASERig.getRigs(), label: getFormView().rig)
			}
			
		} else {
			self.getFormView().typeDropdown.selectRowForDataSourceWithKey(key: Jump.TYPE_SLICK, data: Jump.jump_type, label: getFormView().type)
			self.getFormView().sliderDropdown.selectRowForDataSourceWithKey(key: Jump.SLIDER_UP, data: Jump.slider_config, label: getFormView().slider)
			
			if UserDefaults.standard.object(forKey: SettingsController.DEFAULT_BASE_TYPE) != nil {
				let key = UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_BASE_TYPE)
				getFormView().typeDropdown.selectRowForDataSourceWithKey(key: key, data: Jump.jump_type, label: getFormView().type)
			}
			
			if UserDefaults.standard.object(forKey: SettingsController.DEFAULT_BASE_PC) != nil {
				self.getFormView().pcDropdown.selectRow(at: UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_BASE_PC))
				self.getFormView().pc.text = Jump.pc_sizes[UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_BASE_PC)]
			}
			
			if UserDefaults.standard.object(forKey: SettingsController.DEFAULT_BASE_SLIDER) != nil {
				let key = Array(Jump.slider_config.keys)[UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_BASE_SLIDER)]
				self.getFormView().sliderDropdown.selectRowForDataSourceWithKey(key: key, data: Jump.slider_config, label: getFormView().slider)
			}
		}
		
		self.view.addSubview(getFormView())
	}
	
	override func initFormValidation() {
		self.validator.addRequiredField(field: self.getFormView().exit)
	}
	
	override func assignFormToEntity() {
		
		if getFormView().exitId != nil {
			self.getItem().exit_id = NSNumber(value: getFormView().exitId!)
			
			let exit = Exit.init(primaryKeyValue: getFormView().exitId as NSObject!)!
			
			if exit.isGlobal() {
				exit.global_id = nil
				_ = exit.save()
				
				exit.sendModelNotification()
			}
		} else {
			let exit = Exit()
			exit.name = getFormView().exit.text
			exit.object_type = Exit.TYPE_OTHER as NSNumber?
			exit.height_unit = NSNumber(value: UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_HEIGHT_UNIT))
			_ = exit.save()
			
			exit.sendModelNotification()

			self.getItem().exit_id = exit.id
		}
		
		self.getItem().type = NSNumber(value: getFormView().typeDropdown.getKeyForDataFromSelectedRow(data: Jump.jump_type)!)
		self.getItem().pc_size = NSNumber(value: Int(self.getFormView().pcDropdown.selectedItem!)!)
		self.getItem().slider = NSNumber(value: getFormView().sliderDropdown.getKeyForDataFromSelectedRow(data: Jump.slider_config)!)
		
		self.getItem().date = DateHelper.stringToDate(string: getFormView().date.text!)
		
		if getFormView().delay.text?.isEmpty == false {
			self.getItem().delay = NSNumber(value: Int(getFormView().delay.text!)!)
		}
		
		if getFormView().rigDropdown.indexForSelectedRow != nil && getFormView().rigDropdown.selectedItem != " - " {
			getItem().gear_id = getFormView().rigDropdown.parseIdFromSelection() as NSNumber?
		} else {
			getItem().gear_id = nil
		}
		
		self.getItem().jump_description = getFormView().jumpDescription.text
	}
	
	override func getItem() -> Jump {
		return (super.getItem() as? Jump)!
	}
	
	override func getFormView() -> JumpFormView {
		return (super.getFormView() as? JumpFormView)!
	}
}
