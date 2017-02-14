//
//  TabBarController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let dashboardController = DashboardController()
		let dashboardNavController = UINavigationController(rootViewController: dashboardController)
		dashboardNavController.tabBarItem.image = UIImage(named: "first")
		
		let skydiveController = SkydiveTableViewController()
		skydiveController.title = "Skydives"
		let skydiveNavController = UINavigationController(rootViewController: skydiveController)
		skydiveNavController.tabBarItem.title = "Skydives"
		skydiveNavController.tabBarItem.image = UIImage(named: "second")
		
		let gearController = GearTableController()
		let gearNavController = UINavigationController(rootViewController: gearController)
		gearNavController.tabBarItem.title = "Gear"
		gearNavController.tabBarItem.image = UIImage(named: "first")
		
		let dropzoneController = DropzoneTableController()
		dropzoneController.title = "Dropzones"
		let dropzoneNavController = UINavigationController(rootViewController: dropzoneController)
		dropzoneNavController.tabBarItem.title = "Dropzones"
		dropzoneNavController.tabBarItem.image = UIImage(named: "second")
		dropzoneNavController.navigationBar.backgroundColor = UIColor.white
		
		viewControllers = [dashboardNavController, skydiveNavController, gearNavController, dropzoneNavController]
	}
}
