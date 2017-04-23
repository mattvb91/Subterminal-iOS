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
		
		let registerAction = UITapGestureRecognizer(target: self, action: #selector(register))
		loginView.registerButton.addGestureRecognizer(registerAction)
		
		let loginAction = UITapGestureRecognizer(target: self, action: #selector(login))
		loginView.loginButton.addGestureRecognizer(loginAction)
		
		self.view.addSubview(loginView)
	}
	
	func register(sender:UITapGestureRecognizer) {
		UIApplication.shared.open(NSURL(string:"https://subterminal.eu/register")! as URL, options: [:], completionHandler: nil)
	}
	
	func login(sender:UITapGestureRecognizer) {
		API.instance.authenticate(email: loginView.username.text!, password: loginView.password.text!)
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
