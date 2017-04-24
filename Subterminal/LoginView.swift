//
//  LoginView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 08/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class LoginView: UIView {
	
	var didSetupConstraints: Bool = false

	var shadowViewSkydives = ShadowView()
	var seperator = UIView()
	
	var username = UITextField()
	var password = UITextField()
	
	var loginButton = UIButton(type: UIButtonType.roundedRect)
	var registerButton = UIButton(type: UIButtonType.roundedRect)
	
	var loginDescription = Label(text: "Or Email & Password:")
	var resetPassword = Label(text: "Reset Password")

	var facebookButton = FBSDKLoginButton()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		seperator.backgroundColor = UIColor.gray
		
		username.placeholder = "Email Address"
		password.placeholder = "Password"
		password.isSecureTextEntry = true
		
		username.setBottomBorder()
		username.keyboardType = .emailAddress
		
		password.setBottomBorder()
		
		loginButton.setTitle("Login", for: .normal)
		loginButton.isUserInteractionEnabled = true
		loginButton.layer.borderWidth = 1
		loginButton.layer.cornerRadius = 5
		loginButton.layer.borderColor = UIColor.lightGray.cgColor
		
		registerButton.setTitle("Register", for: .normal)
		registerButton.isUserInteractionEnabled = true
		registerButton.layer.borderWidth = 1
		registerButton.layer.cornerRadius = 5
		registerButton.layer.borderColor = UIColor.lightGray.cgColor

		resetPassword.textColor = self.tintColor
		resetPassword.isUserInteractionEnabled = true

		self.addSubview(facebookButton)
		self.addSubview(seperator)
		self.addSubview(loginDescription)
		
		self.addSubview(username)
		self.addSubview(password)
		
		self.addSubview(loginButton)
		self.addSubview(registerButton)
		
		self.addSubview(resetPassword)
		
		self.setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			facebookButton.autoPinEdge(.left, to: .left, of: self, withOffset: 80)
			facebookButton.autoPinEdge(.right, to: .right, of: self, withOffset: -80)
			facebookButton.autoPinEdge(.top, to: .top, of: self, withOffset: 80)
			
			loginDescription.autoAlignAxis(.vertical, toSameAxisOf: self)
			loginDescription.autoPinEdge(.top, to: .bottom, of: facebookButton, withOffset: 50)
			
			seperator.autoAlignAxis(.vertical, toSameAxisOf: self)
			seperator.autoSetDimensions(to: CGSize(width: 250, height: 1))
			seperator.autoPinEdge(.top, to: .bottom, of: loginDescription, withOffset: 20)
			
			let inputSize = CGSize(width: 250, height: 24)
			username.autoAlignAxis(.vertical, toSameAxisOf: self)
			username.autoSetDimensions(to: inputSize)
			username.autoPinEdge(.top, to: .bottom, of: seperator, withOffset: 50)
			
			password.autoAlignAxis(.vertical, toSameAxisOf: self)
			password.autoSetDimensions(to: inputSize)
			password.autoPinEdge(.top, to: .bottom, of: username, withOffset: 20)
			
			loginButton.autoPinEdge(.left, to: .left, of: username)
			loginButton.autoPinEdge(.top, to: .bottom, of: password, withOffset: 20)
			loginButton.autoSetDimensions(to: CGSize(width: 100, height: 30))

			registerButton.autoPinEdge(.top, to: .top, of: loginButton)
			registerButton.autoPinEdge(.left, to: .right, of: loginButton, withOffset: 20)
			registerButton.autoSetDimensions(to: CGSize(width: 100, height: 30))
			
			resetPassword.autoAlignAxis(.vertical, toSameAxisOf: self)
			resetPassword.autoPinEdge(.top, to: .bottom, of: loginButton, withOffset: 50)

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
