//
//  TunnelView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 05/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class TunnelView: UIView {
	
	var didSetupConstraints: Bool = false
	
	var tunnelDescription: UITextView = UITextView()

	var website: UITextView = UITextView()
	var phone: UITextView = UITextView()
	var email: UITextView = UITextView()
	var map = Subterminal.getMap()
	var aircraft = UILabel()
	
	var websiteLabel = UILabel()
	var emailLabel = UILabel()
	var phoneLabel = UILabel()
	var aircraftLabel = UILabel()
	
	var shadowView = ShadowView()
	
	var images = ImageSlideshow()

	var scrollView = UIScrollView.newAutoLayout()
	var contentView = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		images.contentScaleMode = UIViewContentMode.scaleAspectFill
		images.slideshowInterval = 5

		websiteLabel.text = "Website:"
		websiteLabel.font = UIFont.boldSystemFont(ofSize: 16)
		emailLabel.text = "Email:"
		emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
		phoneLabel.text = "Phone:"
		phoneLabel.font = UIFont.boldSystemFont(ofSize: 16)
		aircraftLabel.text = "Aircraft:"
		aircraftLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		website.font = UIFont.systemFont(ofSize: 14)
		website.textContainer.lineFragmentPadding = 0
		website.textContainerInset = UIEdgeInsets.zero
		website.textContainer.maximumNumberOfLines = 1
		website.textContainer.lineBreakMode = .byTruncatingTail
		website.isEditable = false
		website.dataDetectorTypes = .all
		
		email.font = UIFont.systemFont(ofSize: 14)
		email.textContainer.lineFragmentPadding = 0
		email.textContainerInset = UIEdgeInsets.zero
		email.textContainer.maximumNumberOfLines = 1
		email.textContainer.lineBreakMode = .byTruncatingTail
		email.isEditable = false
		email.dataDetectorTypes = .all
		
		phone.font = UIFont.systemFont(ofSize: 14)
		phone.textContainer.lineFragmentPadding = 0
		phone.textContainerInset = UIEdgeInsets.zero
		phone.textContainer.maximumNumberOfLines = 1
		phone.textContainer.lineBreakMode = .byTruncatingTail
		phone.isEditable = false
		phone.dataDetectorTypes = .all
		
		contentView.addSubview(websiteLabel)
		scrollView.addSubview(website)
		contentView.addSubview(emailLabel)
		scrollView.addSubview(email)
		contentView.addSubview(phoneLabel)
		scrollView.addSubview(phone)
		
		tunnelDescription.isScrollEnabled = false
		tunnelDescription.isUserInteractionEnabled = false
		tunnelDescription.font = UIFont.systemFont(ofSize: 16)

		contentView.addSubview(tunnelDescription)
		scrollView.addSubview(map)

		scrollView.addSubview(shadowView)
		scrollView.sendSubview(toBack: shadowView)

		contentView.isUserInteractionEnabled = true
		scrollView.addSubview(contentView)
		scrollView.alwaysBounceVertical = true
		
		self.addSubview(scrollView)
		self.setNeedsUpdateConstraints()
	}

	override func updateConstraints() {
		if(!didSetupConstraints) {
			
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)

			let fixedWidth = tunnelDescription.frame.size.width
			tunnelDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
			let newSize = tunnelDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
			var newFrame = tunnelDescription.frame
			newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
			tunnelDescription.frame = newFrame;
			
			let size = CGSize(width: UIScreen.main.bounds.width, height: 800 + newFrame.height)
			scrollView.contentSize = size
			scrollView.autoSetDimensions(to: size)

			if(images.superview === scrollView) {
				images.autoPinEdge(.top, to: .top, of: contentView)
				images.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 240))
				websiteLabel.autoPinEdge(.top, to: .bottom, of: images, withOffset: 20)
			}else {
				websiteLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 20)
			}
			
			websiteLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			emailLabel.autoPinEdge(.top, to: .bottom, of: websiteLabel, withOffset: 10.0)
			emailLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			phoneLabel.autoPinEdge(.top, to: .bottom, of: emailLabel, withOffset: 10)
			phoneLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			
			let linkSizes = CGSize(width: (size.width - website.frame.minX) - 20, height: 31)
			
			website.autoPinEdge(.left, to: .right, of: websiteLabel, withOffset: 20)
			website.autoPinEdge(.top, to: .top, of: websiteLabel, withOffset: 0)
			website.autoSetDimensions(to: linkSizes)
			
			email.autoPinEdge(.left, to: .left, of: website)
			email.autoPinEdge(.top, to: .top, of: emailLabel)
			email.autoSetDimensions(to: linkSizes)
			
			phone.autoPinEdge(.left, to: .left, of: website)
			phone.autoPinEdge(.top, to: .top, of: phoneLabel)
			phone.autoSetDimensions(to: linkSizes)
			
			tunnelDescription.autoPinEdge(.top, to: .bottom, of: phoneLabel, withOffset: 20)
			tunnelDescription.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			tunnelDescription.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			
			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: tunnelDescription, withOffset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .left, withInset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .right, withInset: 4)
			
			map.autoPinEdge(.top, to: .bottom, of: tunnelDescription, withOffset: 20.0)
			map.autoPinEdge(.left, to: .left, of: tunnelDescription)
			map.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			map.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 20, height: 200))

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
}
