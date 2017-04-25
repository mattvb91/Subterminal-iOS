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
import SwiftSpinner
import SafariServices

class LoginController: UIViewController, FBSDKLoginButtonDelegate, SFSafariViewControllerDelegate {
	
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
		
		let resetAction = UITapGestureRecognizer(target: self, action: #selector(resetPassword))
		loginView.resetPassword.addGestureRecognizer(resetAction)
		
		self.view.addSubview(loginView)
	}
	
	func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		controller.dismiss(animated: true, completion: nil)
	}
	
	func register(sender:UITapGestureRecognizer) {
		let safariVC = SFSafariViewController(url: NSURL(string: "https://subterminal.eu/register")! as URL)
		self.present(safariVC, animated: true, completion: nil)
		safariVC.delegate = self
	}
	
	func resetPassword(sender:UITapGestureRecognizer) {
		let safariVC = SFSafariViewController(url: NSURL(string: "https://subterminal.eu/password/reset")! as URL)
		self.present(safariVC, animated: true, completion: nil)
		safariVC.delegate = self
	}
	
	func login(sender:UITapGestureRecognizer) {
		SwiftSpinner.show("Authenticating...")
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
