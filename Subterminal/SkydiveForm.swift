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
		getItem().delay = Int(getFormView().delay.text!)
		getItem().exit_altitude = Int(getFormView().exitAlt.text!)
		getItem().deploy_altidude = Int(getFormView().deployAlt.text!)
		getItem().skydive_description = getFormView().descriptionInput.text
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
