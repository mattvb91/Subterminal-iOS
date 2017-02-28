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
		
		self.view.addSubview(jumpView)
	}
}
