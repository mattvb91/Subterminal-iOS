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

	var item: Rig?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let formView = GearFormView.newAutoLayout()
		
		if let item = item {
			formView.containerManufacturer.text = item.container_manufacturer
			formView.containerModel.text = item.container_model
			formView.containerSerial.text = item.container_serial
			formView.containerDateInUse.text = item.container_date_in_use
		}
		
		self.view.addSubview(formView)
    }
	
	//MARK: Actions
	
	@IBAction func save(_ sender: UIBarButtonItem) {
		
		/*
		if item == nil {
			item = Rig()
		}
		
		
		if (item?.save())! {
			os_log("saved")
		}
*/
		
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)

		navigationController?.popViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}
}
