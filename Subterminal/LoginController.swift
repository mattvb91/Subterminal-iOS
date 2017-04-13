//
//  LoginController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 08/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import UIKit

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
	
	let loginView = LoginView.newAutoLayout()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Sign In"
		
		loginView.facebookButton.readPermissions = ["public_profile", "email", "user_friends"]
		loginView.facebookButton.delegate = self
		
		self.view.addSubview(loginView)
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
