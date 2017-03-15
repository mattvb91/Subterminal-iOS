//
//  ExitFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 02/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import SwiftSpinner
import CoreLocation
import DropDown

class ExitFormView: UIView {
	
	var didSetupConstraints: Bool = false
	var requiredBlock:((_: [Error]) -> Void)?
	
	var nameLabel = Label(text: "Name")
	var typeLabel = Label(text: "Type")
	var unitLabel = Label(text: "Height Unit")
	var rockdropLabel = Label(text: "Rockdrop distance")
	var altitudeToLandingLabel = Label(text: "Altitude to landing")
	var descriptionLabel = Label(text: "Description")
	var latitudeLabel = Label(text: "Latitude")
	var longtitudeLabel = Label(text: "Longtitude")
	
	var arrowImage = UIImage(named: "arrow_down")
	
	var typeArrow = UIImageView()
	var typeDropdown = DropDown()
	
	var name = UITextField()
	var type = UILabel()
	var heightUnit = UISegmentedControl(items: ["Metric (m)", "Imperial (ft)"])
	var rockdrop = UITextField()
	var altitudeToLanding = UITextField()
	var exitDescription = UITextView()
	var latitude = UITextField()
	var longtitude = UITextField()
	
	var coordinatesButton = UIButton(type: UIButtonType.roundedRect)
	
	var scrollView = UIScrollView.newAutoLayout()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		scrollView.addSubview(nameLabel)
		scrollView.addSubview(typeLabel)
		scrollView.addSubview(unitLabel)
		scrollView.addSubview(rockdropLabel)
		scrollView.addSubview(altitudeToLandingLabel)
		scrollView.addSubview(descriptionLabel)
		scrollView.addSubview(latitudeLabel)
		scrollView.addSubview(longtitudeLabel)
		
		name.setBottomBorder()
		type.text = Exit.types[0]
		
		rockdrop.keyboardType = UIKeyboardType.numberPad
		rockdrop.setBottomBorder()
		rockdrop.placeholder = "0"
		
		altitudeToLanding.keyboardType = UIKeyboardType.numberPad
		altitudeToLanding.setBottomBorder()
		altitudeToLanding.placeholder = "0"
			
		typeArrow.image = arrowImage

		typeDropdown.anchorView = type
		typeDropdown.dataSource = Exit.getTypesForSelect()
		
		typeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
			self.type.text = item
		}
		
		let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapType))
		tapGesture.numberOfTapsRequired = 1
		type.isUserInteractionEnabled =  true
		type.addGestureRecognizer(tapGesture)

		scrollView.addSubview(name)
		scrollView.addSubview(type)
		scrollView.addSubview(typeArrow)
		
		heightUnit.selectedSegmentIndex = UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_HEIGHT_UNIT)
		scrollView.addSubview(heightUnit)
		
		exitDescription.font = UIFont.systemFont(ofSize: 16)
		exitDescription.layer.borderWidth = 1
		exitDescription.layer.borderColor = UIColor.lightGray.cgColor
		
		scrollView.addSubview(rockdrop)
		scrollView.addSubview(altitudeToLanding)
		scrollView.addSubview(exitDescription)
		
		coordinatesButton.setTitle("Load coordinates from GPS", for: .normal)
		coordinatesButton.layer.borderWidth = 1
		coordinatesButton.layer.cornerRadius = 5
		coordinatesButton.layer.borderColor = UIColor.lightGray.cgColor
		
		latitude.setBottomBorder()
		latitude.placeholder = "0.00000"
		latitude.keyboardType = UIKeyboardType.decimalPad
		
		longtitude.setBottomBorder()
		longtitude.placeholder = "0.00000"
		longtitude.keyboardType = UIKeyboardType.decimalPad
		
		scrollView.addSubview(coordinatesButton)
		scrollView.addSubview(latitude)
		scrollView.addSubview(longtitude)
		
		scrollView.isUserInteractionEnabled = true
		scrollView.delaysContentTouches = false
		scrollView.canCancelContentTouches = false
		
		scrollView.bringSubview(toFront: heightUnit)
		
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
			self.didSetupConstraints = true
			
			nameLabel.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)
			nameLabel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 20)
			
			name.autoPinEdge(.left, to: .left, of: nameLabel)
			name.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 8)
			name.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 35, height: 31))
			
			typeLabel.autoPinEdge(.top, to: .bottom, of: name, withOffset: 20)
			typeLabel.autoPinEdge(.left, to: .left, of: nameLabel)
			
			type.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 8)
			type.autoPinEdge(.left, to: .left, of: typeLabel)
			typeArrow.autoPinEdge(.left, to: .right, of: type, withOffset: 5)
			typeArrow.autoPinEdge(.top, to: .top, of: type, withOffset: 10)
			
			unitLabel.autoPinEdge(.left, to: .right, of: typeLabel, withOffset: 160)
			unitLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			heightUnit.autoPinEdge(.left, to: .left, of: unitLabel, withOffset: -40)
			heightUnit.autoPinEdge(.top, to: .bottom, of: unitLabel, withOffset: 8)
			
			rockdropLabel.autoPinEdge(.top, to: .bottom, of: type, withOffset: 20)
			rockdropLabel.autoPinEdge(.left, to: .left, of: nameLabel)
			
			rockdrop.autoPinEdge(.top, to: .bottom, of: rockdropLabel, withOffset: 8)
			rockdrop.autoPinEdge(.left, to: .left, of: rockdropLabel)
			rockdrop.autoSetDimensions(to: CGSize(width: 120, height: 31))
			
			altitudeToLandingLabel.autoPinEdge(.top, to: .top, of: rockdropLabel)
			altitudeToLandingLabel.autoPinEdge(.left, to: .left, of: unitLabel)
			
			altitudeToLanding.autoPinEdge(.left, to: .left, of: altitudeToLandingLabel)
			altitudeToLanding.autoPinEdge(.top, to: .bottom, of: altitudeToLandingLabel, withOffset: 8)
			altitudeToLanding.autoSetDimensions(to: CGSize(width: 120, height: 31))
			
			descriptionLabel.autoPinEdge(.left, to: .left, of: nameLabel)
			descriptionLabel.autoPinEdge(.top, to: .bottom, of: rockdrop, withOffset: 20)
			
			exitDescription.autoPinEdge(.left, to: .left, of: descriptionLabel)
			exitDescription.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 8)
			exitDescription.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 35, height: 150))
			
			coordinatesButton.autoPinEdge(.left, to: .left, of: descriptionLabel)
			coordinatesButton.autoPinEdge(.top, to: .bottom, of: exitDescription, withOffset: 30)
			coordinatesButton.autoSetDimensions(to: CGSize(width: 200, height: 30))
			
			latitudeLabel.autoPinEdge(.left, to: .left, of: nameLabel)
			latitudeLabel.autoPinEdge(.top, to: .bottom, of: coordinatesButton, withOffset: 20)
			
			latitude.autoPinEdge(.left, to: .left, of: latitudeLabel)
			latitude.autoPinEdge(.top, to: .bottom, of: latitudeLabel, withOffset: 8)
			latitude.autoSetDimensions(to: CGSize(width: 120, height: 31))

			longtitudeLabel.autoPinEdge(.left, to: .left, of: unitLabel)
			longtitudeLabel.autoPinEdge(.top, to: .top, of: latitudeLabel)
			
			longtitude.autoPinEdge(.top, to: .top, of: latitude)
			longtitude.autoPinEdge(.left, to: .left, of: longtitudeLabel)
			longtitude.autoSetDimensions(to: CGSize(width: 120, height: 31))
		}
		
		super.updateConstraints()
	}
	
	func tapType(recognizer: UITapGestureRecognizer) {
		typeDropdown.show()
	}
}
