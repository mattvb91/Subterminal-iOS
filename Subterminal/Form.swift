//
//  BaseForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import os.log

class Form: UIViewController, UITextFieldDelegate {

    var item: Model?
	var formView: UIView!
	var validator: FormValidator = FormValidator()
	
	/*
	 * Add cancel/save buttons
	 */
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction))
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
		
		self.navigationItem.rightBarButtonItem = saveButton
		self.navigationItem.leftBarButtonItem = cancelButton
		
		self.initFormValidation()
    }
	
	//Override to add required validation fields
	func initFormValidation() {}
	
	/*
	 * Check form is valid, Assign form to entity, save the entity
	 */
	func saveAction() {
		if self.validator.isValid() {
			assignFormToEntity()
			_ = self.getItem().save()
			
			let notificationName = type(of: self.getItem()).getNotificationName()
			NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName), object: nil)
			
			cancelAction()
		}
	}

	/*
	 * Slide down
     */
    func cancelAction() {
		
		if(getItem().id == nil) {
			let transition = CATransition()
			transition.duration = 0.5
			transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
			transition.type = kCATransitionPush;
			transition.subtype = kCATransitionFromBottom
			self.navigationController?.view.layer.add(transition, forKey: kCATransition)
			self.navigationController?.popViewController(animated: false)
		} else {
			self.navigationController?.popViewController(animated: true)
			dismiss(animated: true, completion: nil)
		}
	}
	
	/*
	 * Get the current active item
	 */
	func getItem() -> Model {
		return self.item!
	}

	/*
	 * Override to validate
	 */
	func formIsValid() -> Bool {
		return false
	}
	
	func getFormView() -> UIView {
		return self.formView!
	}
	
	/*
	 * Get the input values back over to the entity
	 */
	func assignFormToEntity() {
		fatalError("assignFormToEntity() not implemented")
	}
	
	func getNotificationName() -> String {
		fatalError("getNotificationName() not implemented")
	}
}
