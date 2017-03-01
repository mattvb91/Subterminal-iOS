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
		super.viewDidLoad()
		
		self.formView = JumpFormView.newAutoLayout()
		
		if getItem().id != nil {
			self.getFormView().date.text = DateHelper.dateToString(date: self.getItem().date!)
			self.getFormView().exitId = getItem().exit()?.id as Int?
			self.getFormView().exit.text = getItem().exit()?.name
			self.getFormView().jumpDescription.text = getItem().jump_description
			self.getFormView().delay.text = getItem().delay?.description
			self.getFormView().pc.text = getItem().pc_size?.description
		}
		
		self.view.addSubview(getFormView())
	}
	
	override func formIsValid() -> Bool {
		return true
	}
	
	override func assignFormToEntity() {

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
