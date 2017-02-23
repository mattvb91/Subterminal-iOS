//
//  SkydiveViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 16/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveViewController: UIViewController {

	var item: Skydive?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let skydiveView = SkydiveView.newAutoLayout()
		
		if let item = item {
			skydiveView.skydive = item
			
			skydiveView.skydiveDescription.text = item.skydive_description
			skydiveView.skydiveDescription.sizeToFit()
			
			if let exitAltitude = item.exit_altitude {
				skydiveView.exitAlt.text = String(describing: exitAltitude)
			}
			
			if let deployAlt = item.deploy_altidude {
				skydiveView.deployAlt.text = String(describing: deployAlt)
			}
			
			if let delay = item.delay {
				skydiveView.delay.text = String(describing: delay)
			}
			
			skydiveView.rig.text = (item.rig()?.container_manufacturer!)! + " - " + (item.rig()?.container_model!)!
			skydiveView.dropzone.text = item.dropzone()?.name
			skydiveView.aircraft.text = item.aircraft()?.name
			skydiveView.type.text = item.getFormattedType()
		}
		
		self.view.addSubview(skydiveView)
	}
}
