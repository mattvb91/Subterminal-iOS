//
//  DashboardController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

import FBSDKLoginKit

class DashboardController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.lightGray
		
		let dashboardView = DashboardView.newAutoLayout()
		dashboardView.loginView.readPermissions = ["public_profile", "email", "user_friends"]
		dashboardView.loginView.delegate = self
		
		dashboardView.premiumButton.addTarget(self, action: #selector(self.premium(_:)), for: .touchUpInside)
		
		let segment: UISegmentedControl = UISegmentedControl(items: ["Skydive", "B.A.S.E."])
		segment.selectedSegmentIndex = Subterminal.mode
		segment.sizeToFit()
		segment.tintColor = self.view.tintColor
		segment.addTarget(self, action: #selector(changeMode), for: .valueChanged)

		self.navigationItem.titleView = segment
		self.view.addSubview(dashboardView)
    }
	
	@objc func premium(_ sender: AnyObject?) {
		self.navigationController?.pushViewController(PremiumController(), animated: true)
	}
	
	@objc func changeMode(segment: UISegmentedControl) {
		Subterminal.changeMode(mode: (segment.selectedSegmentIndex))
	}
	
	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
		debugPrint("User Logged In")
		
		if ((error) != nil)
		{
			// Process error
		}
		else if result.isCancelled {
			// Handle cancellations
			debugPrint("Cancelled")
		}
		else {
			// If you ask for multiple permissions at once, you
			// should check if specific permissions missing
			if result.grantedPermissions.contains("email")
			{
				// Do work
				Subterminal.user.setFacebookUserData()
			}
		}
	}
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
		debugPrint("User Logged Out")
	}
}
