//
//  BaseForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class Form: UIViewController, UITextFieldDelegate {

    var entity: Model?
	
	/*
	 * Add cancel/save buttons
	 */
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction))
		
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
		
		self.navigationItem.rightBarButtonItem = saveButton
		self.navigationItem.leftBarButtonItem = cancelButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func saveAction() {
		
	}

    func cancelAction() {
		
		let transition = CATransition()
		transition.duration = 0.5
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		transition.type = kCATransitionPush;
		transition.subtype = kCATransitionFromBottom
		self.navigationController?.view.layer.add(transition, forKey: kCATransition)
		self.navigationController?.popViewController(animated: false)
    }

}
