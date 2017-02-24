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
	var website: UILabel = UILabel()
	var phone: UILabel = UILabel()
	var email: UILabel = UILabel()
	var map: MKMapView = MKMapView()
	var aircraft = UILabel()
	
	var websiteLabel = UILabel()
	var emailLabel = UILabel()
	var phoneLabel = UILabel()
	var aircraftLabel = UILabel()

	var shadowView = ShadowView()
	
	var images = ImageSlideshow()
	var tagview = HTagView()
	
	var tagview_data = [String]()
	
	var dropzone: Dropzone?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		images.contentScaleMode = UIViewContentMode.scaleAspectFill
		images.slideshowInterval = 5
		self.addSubview(images)
		
		websiteLabel.text = "Website:"
		websiteLabel.font = UIFont.boldSystemFont(ofSize: 16)
		emailLabel.text = "Email:"
		emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
		phoneLabel.text = "Phone:"
		phoneLabel.font = UIFont.boldSystemFont(ofSize: 16)
		aircraftLabel.text = "Aircraft:"
		aircraftLabel.font = UIFont.boldSystemFont(ofSize: 16)

		self.addSubview(websiteLabel)
		self.addSubview(website)
		self.addSubview(emailLabel)
		self.addSubview(email)
		self.addSubview(phoneLabel)
		self.addSubview(phone)
		self.addSubview(aircraftLabel)
		self.addSubview(aircraft)
		
		dropzoneDescription.text = dropzone?.dropzone_description
		dropzoneDescription.isScrollEnabled = false
		dropzoneDescription.isUserInteractionEnabled = false
		dropzoneDescription.font = UIFont.systemFont(ofSize: 16)
		
		self.addSubview(dropzoneDescription)
		self.addSubview(map)
		
		tagview.dataSource = self
		tagview.tagSecondBackColor = UIColor(red: 121/255, green: 196/255, blue: 1, alpha: 1)
		
		self.addSubview(tagview)
		self.addSubview(shadowView)
		self.sendSubview(toBack: shadowView)
		
		self.setNeedsUpdateConstraints()
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			if(images.superview === self) {
				images.autoPinEdge(toSuperviewEdge: .top, withInset: 60)
				images.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 240))
				websiteLabel.autoPinEdge(.top, to: .bottom, of: images, withOffset: 20)
			}else {
				websiteLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 80)
			}
			
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
			
			aircraftLabel.autoPinEdge(.left, to: .left, of: phoneLabel)
			aircraftLabel.autoPinEdge(.top, to: .bottom, of: phoneLabel, withOffset: 10)
			aircraft.autoPinEdge(.left, to: .left, of: website)
			aircraft.autoPinEdge(.top, to: .top, of: aircraftLabel)
			
			dropzoneDescription.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 20)
			dropzoneDescription.autoSetDimension(.height, toSize: dropzoneDescription.contentSize.height)
			dropzoneDescription.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			dropzoneDescription.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			
			tagview.autoPinEdge(.top, to: .bottom, of: dropzoneDescription)
			tagview.autoPinEdge(toSuperviewEdge: .right)
			tagview.autoPinEdge(toSuperviewEdge: .left)
			
			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 75)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: tagview, withOffset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .left, withInset: 4)
			shadowView.autoPinEdge(toSuperviewEdge: .right, withInset: 4)

			map.autoPinEdge(.top, to: .bottom, of: tagview, withOffset: 20.0)
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
