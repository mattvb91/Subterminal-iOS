//
//  TabBarController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import RAMAnimatedTabBarController

class TabBarController: RAMAnimatedTabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let dashboardController = DashboardController()
		let dashboardNavController = UINavigationController(rootViewController: dashboardController)
		
		let tabBarIconDashboard: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "dashboard").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "dashboard"))
		tabBarIconDashboard.animation = RAMBounceAnimation()
		dashboardNavController.tabBarItem = tabBarIconDashboard

		
		if Subterminal.mode == Subterminal.MODE_SKYDIVE {
		
			let skydiveController = SkydiveTableViewController()
			skydiveController.title = "Skydives"
			let skydiveNavController = UINavigationController(rootViewController: skydiveController)
		
			let tabBarIconSkydive: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Skydives", image: #imageLiteral(resourceName: "skydive").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "skydive"))
			tabBarIconSkydive.animation = RAMBounceAnimation()
			skydiveController.tabBarItem = tabBarIconSkydive
			
			let gearController = GearTableController()
			let gearNavController = UINavigationController(rootViewController: gearController)

			let tabBarIconGear: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Gear", image: #imageLiteral(resourceName: "rig").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "rig"))
			tabBarIconGear.animation = RAMBounceAnimation()
			gearController.tabBarItem = tabBarIconGear

			
			let dropzoneController = DropzoneTableController()
			dropzoneController.title = "Dropzones"
			let dropzoneNavController = UINavigationController(rootViewController: dropzoneController)
		
			let tabBarIconDropzone: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Dropzones", image: #imageLiteral(resourceName: "map").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "map"))
			tabBarIconDropzone.animation = RAMBounceAnimation()
			dropzoneController.tabBarItem = tabBarIconDropzone
			
			viewControllers = [dashboardNavController, skydiveNavController, gearNavController, dropzoneNavController]
		} else {
			
			let exitsController = ExitsTableController()
			exitsController.title = "Exits"
			let exitsNavController = UINavigationController(rootViewController: exitsController)
			
			let tabBarIconExits: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Exits", image: #imageLiteral(resourceName: "map").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "map"))
			tabBarIconExits.animation = RAMBounceAnimation()
			exitsController.tabBarItem = tabBarIconExits

			
			viewControllers = [dashboardNavController, exitsNavController]
		}
	}
}
