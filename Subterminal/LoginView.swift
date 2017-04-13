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
	
	var loginButton = UIButton()
	var registerButton = UIButton()
	
	var loginDescription = Label(text: "Or username & password:")

	var facebookButton = FBSDKLoginButton()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		seperator.backgroundColor = UIColor.gray
		
		username.placeholder = "Username"
		password.placeholder = "Password"
		password.isSecureTextEntry = true
		
		username.setBottomBorder()
		password.setBottomBorder()

		self.addSubview(facebookButton)
		self.addSubview(seperator)
		self.addSubview(loginDescription)
		
		self.addSubview(username)
		self.addSubview(password)
		
		self.addSubview(loginButton)
		self.addSubview(registerButton)
		
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
			loginDescription.autoPinEdge(.top, to: .bottom, of: facebookButton, withOffset: 20)
			
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

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
