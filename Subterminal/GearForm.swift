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

	//MARK: Properties
	@IBOutlet weak var containerManufacturer: UITextField!
	@IBOutlet weak var containerModel: UITextField!
	@IBOutlet weak var containerSerial: UITextField!
	@IBOutlet weak var containerDateInUse: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	@IBAction func save(_ sender: UIBarButtonItem) {
		
		let rig = Rig()
		
		rig.container_manufacturer = containerManufacturer.text
		rig.container_model = containerModel.text
		rig.container_serial = containerSerial.text
		rig.container_date_in_use = containerDateInUse.text
		
		if rig.save() {
			os_log("saved")
		}
		
		dismiss(animated: true, completion: nil)
	}
}
