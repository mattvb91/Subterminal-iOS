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
		
		let tabBarIconDashboard: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "first").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "first"))
		tabBarIconDashboard.animation = RAMBounceAnimation()
		dashboardNavController.tabBarItem = tabBarIconDashboard
		
		let skydiveController = SkydiveTableViewController()
		skydiveController.title = "Skydives"
		let skydiveNavController = UINavigationController(rootViewController: skydiveController)
		
		let tabBarIconSkydive: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Skydives", image: #imageLiteral(resourceName: "second").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "second"))
		tabBarIconSkydive.animation = RAMBounceAnimation()
		skydiveController.tabBarItem = tabBarIconSkydive

		let gearController = GearTableController()
		let gearNavController = UINavigationController(rootViewController: gearController)

		let tabBarIconGear: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Gear", image: #imageLiteral(resourceName: "first").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "first"))
		tabBarIconGear.animation = RAMBounceAnimation()
		gearController.tabBarItem = tabBarIconGear

		let dropzoneController = DropzoneTableController()
		dropzoneController.title = "Dropzones"
		let dropzoneNavController = UINavigationController(rootViewController: dropzoneController)
		
		let tabBarIconDropzone: RAMAnimatedTabBarItem = RAMAnimatedTabBarItem(title: "Dropzone", image: #imageLiteral(resourceName: "second").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "second"))
		tabBarIconDropzone.animation = RAMBounceAnimation()
		dropzoneController.tabBarItem = tabBarIconDropzone

		
		viewControllers = [dashboardNavController, skydiveNavController, gearNavController, dropzoneNavController]
	}
}
