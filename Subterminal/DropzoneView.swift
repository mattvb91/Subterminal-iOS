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
import ImageSlideshow
import AlamofireImage
import HTagView

class DropzoneView: UIView, HTagViewDataSource {

	var didSetupConstraints: Bool = false
	
	var dropzoneDescription: UITextView = UITextView()
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
	var tagview = HTagView()
	
	var tagview_data = [String]()
		
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
		contentView.addSubview(aircraftLabel)
		contentView.addSubview(aircraft)
		
		dropzoneDescription.isScrollEnabled = false
		dropzoneDescription.isUserInteractionEnabled = false
		dropzoneDescription.font = UIFont.systemFont(ofSize: 16)
		
		contentView.addSubview(dropzoneDescription)
		scrollView.addSubview(map)
		
		tagview.dataSource = self
		tagview.tagSecondBackColor = UIColor(red: 121/255, green: 196/255, blue: 1, alpha: 1)
		
		contentView.addSubview(tagview)
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

			let fixedWidth = dropzoneDescription.frame.size.width
			dropzoneDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
			let newSize = dropzoneDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
			var newFrame = dropzoneDescription.frame
			newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
			dropzoneDescription.frame = newFrame;
			
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
			
			aircraftLabel.autoPinEdge(.left, to: .left, of: phoneLabel)
			aircraftLabel.autoPinEdge(.top, to: .bottom, of: phoneLabel, withOffset: 10)
			aircraft.autoPinEdge(.left, to: .left, of: website)
			aircraft.autoPinEdge(.top, to: .top, of: aircraftLabel)
			
			dropzoneDescription.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 20)
			dropzoneDescription.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			dropzoneDescription.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			
			tagview.autoPinEdge(.top, to: .bottom, of: dropzoneDescription)
			tagview.autoPinEdge(toSuperviewEdge: .right)
			tagview.autoPinEdge(toSuperviewEdge: .left)
			
			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: tagview, withOffset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .left, withInset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .right, withInset: 4)

			map.autoPinEdge(.top, to: .bottom, of: tagview, withOffset: 20.0)
			map.autoPinEdge(.left, to: .left, of: dropzoneDescription)
			map.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			map.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 20, height: 200))

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	
	}
	
	func numberOfTags(_ tagView: HTagView) -> Int {
		return tagview_data.count
	}
	
	func tagView(_ tagView: HTagView, titleOfTagAtIndex index: Int) -> String {
		return tagview_data[index]
	}
	
	func tagView(_ tagView: HTagView, tagTypeAtIndex index: Int) -> HTagType {
		return HTagType.select
	}
}
