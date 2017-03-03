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
	
	var loginView = FBSDKLoginButton()
	var premiumButton = UIButton()
	
	var scrollView = UIScrollView.newAutoLayout()
	
	var didSetupConstraints: Bool = false
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = UIColor.white
		
		if (FBSDKAccessToken.current() != nil) {
			// User is already logged in, do work such as go to next view controller.
		} else {
			scrollView.addSubview(loginView)
		}
		
		premiumButton.setTitle("GO PREMIUM", for: .normal)
		premiumButton.backgroundColor = UIColor.init(cgColor: (loginView.backgroundColor?.cgColor)!)
	
		scrollView.addSubview(premiumButton)
		self.addSubview(scrollView)

		self.setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			let size = CGSize(width: UIScreen.main.bounds.width, height: 700)
			scrollView.contentSize = size
			scrollView.autoSetDimensions(to: size)
			
			premiumButton.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)
			premiumButton.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 30)
			premiumButton.autoSetDimensions(to: CGSize(width: 150, height: 30))

			
			loginView.autoPinEdge(.left, to: .right, of: premiumButton, withOffset: 40)
			loginView.autoPinEdge(.top, to: .top, of: premiumButton)
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
}
