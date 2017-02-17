//
//  DropzoneView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import MapKit
import PureLayout

class DropzoneView: UIView {

	var didSetupConstraints: Bool = false
	
	var dropzoneDescription: UITextView = UITextView()
	var website: UILabel = UILabel()
	var phone: UILabel = UILabel()
	var email: UILabel = UILabel()
	var map: MKMapView = MKMapView()
	
	var websiteLabel = UILabel()
	var emailLabel = UILabel()
	var phoneLabel = UILabel()

	var shadowView = ShadowView()

	var dropzone: Dropzone?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		websiteLabel.text = "Website:"
		websiteLabel.font = UIFont.boldSystemFont(ofSize: 16)
		emailLabel.text = "Email:"
		emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
		phoneLabel.text = "Phone:"
		phoneLabel.font = UIFont.boldSystemFont(ofSize: 16)

		self.addSubview(websiteLabel)
		self.addSubview(website)
		self.addSubview(emailLabel)
		self.addSubview(email)
		self.addSubview(phoneLabel)
		self.addSubview(phone)
		
		dropzoneDescription.text = dropzone?.dropzone_description
		dropzoneDescription.isScrollEnabled = false
		self.addSubview(dropzoneDescription)
		self.addSubview(map)
		
		self.addSubview(shadowView)
		self.sendSubview(toBack: shadowView)
		
		self.setNeedsUpdateConstraints()
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)

			websiteLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 80)
			websiteLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			emailLabel.autoPinEdge(.top, to: .bottom, of: websiteLabel, withOffset: 10.0)
			emailLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			phoneLabel.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 10)
			phoneLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			
			website.autoPinEdge(.left, to: .right, of: websiteLabel, withOffset: 20)
			website.autoPinEdge(.top, to: .top, of: websiteLabel, withOffset: 0)
			website.autoSetDimension(.height, toSize: 25.0)
			
			email.autoPinEdge(.left, to: .left, of: website)
			email.autoPinEdge(.top, to: .top, of: emailLabel)
			email.autoSetDimension(.height, toSize: 25.0)

			phone.autoPinEdge(.left, to: .left, of: website)
			phone.autoPinEdge(.top, to: .top, of: phoneLabel)
			phone.autoSetDimension(.height, toSize: 25.0)
			
			dropzoneDescription.autoPinEdge(.top, to: .bottom, of: phoneLabel, withOffset: 20)
			dropzoneDescription.autoSetDimension(.height, toSize: dropzoneDescription.contentSize.height)
			dropzoneDescription.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			dropzoneDescription.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			
			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 75)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: dropzoneDescription, withOffset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .left, withInset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .right, withInset: 4)

			map.autoPinEdge(.top, to: .bottom, of: dropzoneDescription, withOffset: 20.0)
			map.autoPinEdge(.left, to: .left, of: dropzoneDescription)
			map.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			map.autoSetDimension(.height, toSize: 200)

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	
	}
}
