//
//  DashboardView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 24/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class DashboardView: UIView {
	
	var loginView : FBSDKLoginButton = FBSDKLoginButton()
	var premiumButton = UIButton()
	
	var didSetupConstraints: Bool = false
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = UIColor.white
		
		if (FBSDKAccessToken.current() != nil) {
			// User is already logged in, do work such as go to next view controller.
		} else {
			self.addSubview(loginView)
		}
		
		premiumButton.setTitle("GO PREMIUM", for: .normal)
		premiumButton.backgroundColor = UIColor.init(cgColor: (loginView.backgroundColor?.cgColor)!)
		
		self.addSubview(premiumButton)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			loginView.autoPinEdge(.right, to: .right, of: self, withOffset: -15)
			loginView.autoPinEdge(.top, to: .top, of: self, withOffset: 80)
			
			premiumButton.autoPinEdge(.top, to: .top, of: loginView)
			premiumButton.autoPinEdge(.right, to: .left, of: loginView, withOffset: -30)
			premiumButton.autoSetDimensions(to: CGSize(width: 150, height: 30))
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
}
