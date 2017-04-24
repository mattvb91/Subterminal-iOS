//
//  User.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 22/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class User {
	
	var email: String?
	var is_premium: Bool = false
	var token: String?
	var name: String?
	
	let facebookPermissions = ["public_profile", "email", "user_friends"]
	
	func setFacebookUserData()
	{
		let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,email, name"])
		graphRequest.start(completionHandler: { (connection, result, error) -> Void in
			
			if ((error) != nil)
			{
				// Process error
				debugPrint("Error: \(error)")
			}
			else
			{
				let data = result as! NSDictionary
				
				self.email = data.value(forKey: "email") as! String?
				self.name = data.value(forKey: "name") as! String?
				self.token = FBSDKAccessToken.current().tokenString
				
				API.instance.createOrUpdateRemoveUser()
			}
		})
	}
	
	//Get facebook token or get our manual token
	func getToken() -> String? {
		if FBSDKAccessToken.current() != nil, FBSDKAccessToken.current().expirationDate > Date() {
			return FBSDKAccessToken.current().tokenString
		}
		
		return UserDefaults.standard.value(forKey: "USER_TOKEN") as? String
	}
	
	func setToken(token: String) {
		UserDefaults.standard.setValue(token, forKey: "USER_TOKEN")
	}
	
	//Check is the user currently logged in
	func isLoggedIn() -> Bool {
		if FBSDKAccessToken.current() != nil, FBSDKAccessToken.current().tokenString != nil {
			return FBSDKAccessToken.current().expirationDate > Date()
		}
		
		if getToken() == nil {
			return false
		}
		
		return true
	}
	
	func isPremium() -> Bool {
		return UserDefaults.standard.bool(forKey: "user_premium")
	}
	
	//Log user out
	func logout() -> Void {
		UserDefaults.standard.removeObject(forKey: "USER_TOKEN")
		return FBSDKLoginManager().logOut()
	}

}
