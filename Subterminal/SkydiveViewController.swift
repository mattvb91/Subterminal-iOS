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
		}
		
		self.view.addSubview(skydiveView)
	}
}
