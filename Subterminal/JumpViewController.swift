//
//  JumpViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class JumpViewController: UIViewController {
	
	var item: Jump!
	let jumpView = JumpView.newAutoLayout()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))
		self.navigationItem.rightBarButtonItem = editButton
		
		if let item = item {
			jumpView.exit.text = item.exit()?.name
			jumpView.delay.text = item.delay?.description
			jumpView.pc.text = item.pc_size?.description
			jumpView.slider.text = item.getFormattedSlider()
			jumpView.jumpDescription.text = item.jump_description
			jumpView.jumpDescription.sizeToFit()
		}
		
		self.view.addSubview(jumpView)
	}
	
	
	func editAction() {
		var formController = JumpForm()
		formController.item = self.item
		
		self.navigationController?.pushViewController(formController, animated: true)
	}
}
