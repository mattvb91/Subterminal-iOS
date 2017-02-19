//
//  SkydiveFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 15/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import SharkORM
import DropDown

class SkydiveFormView: UIView {

	var didSetupConstraints: Bool = false
	
	var dropzoneLabel = Label(text: "Dropzone")
	var	dateLabel = Label(text: "Date")
	var	aircraftLabel = Label(text: "Aircraft")
	var	rigLabel = Label(text: "Rig")
	var	typeLabel = Label(text: "Type")
	var	heightUnitLabel = Label(text: "Height Unit")
	var	cutawayLabel = Label(text: "Cutaway")
	var	exitAltitudeLabel = Label(text: "Exit Alt.")
	var	deployAltitudeLabel = Label(text: "Deploy Alt.")
	var	delayLabel = Label(text: "Delay")
	var	descriptionLabel = Label(text: "Description")
	
	var aircraft = DropDown()
	
	var exitAlt = UITextField()
	var deployAlt = UITextField()
	var delay = UITextField()
	
	var heightUnit = UISwitch()
	
	var descriptionInput = UITextView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		exitAlt.setBottomBorder()
		exitAlt.placeholder = "13000"
		deployAlt.setBottomBorder()
		deployAlt.placeholder = "3000"
		delay.setBottomBorder()
		delay.placeholder = "60"
		
		descriptionInput.layer.borderColor = UIColor.gray.cgColor
		descriptionInput.layer.borderWidth = 1
		descriptionInput.layer.cornerRadius = 5
		
		aircraft.anchorView = aircraftLabel
		aircraft.dataSource = Aircraft.getForSelect()
		
		let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapResponse))
		tapGesture.numberOfTapsRequired = 1
		aircraftLabel.isUserInteractionEnabled =  true
		aircraftLabel.addGestureRecognizer(tapGesture)
		
		self.addSubview(aircraft)
		
		self.addSubview(dropzoneLabel)
		self.addSubview(dateLabel)
		self.addSubview(aircraftLabel)
		self.addSubview(rigLabel)
		self.addSubview(typeLabel)
		self.addSubview(heightUnitLabel)
		self.addSubview(cutawayLabel)
		self.addSubview(exitAltitudeLabel)
		self.addSubview(deployAltitudeLabel)
		self.addSubview(delayLabel)
		self.addSubview(descriptionLabel)
		
		self.addSubview(exitAlt)
		self.addSubview(deployAlt)
		self.addSubview(delay)
		
		self.addSubview(heightUnit)
		self.addSubview(descriptionInput)

		setNeedsUpdateConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			dropzoneLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			dropzoneLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
			
			dateLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			dateLabel.autoPinEdge(.top, to: .bottom, of: dropzoneLabel, withOffset: 40)
			
			aircraftLabel.autoPinEdge(.top, to: .top, of: dateLabel)
			aircraftLabel.autoPinEdge(.left, to: .right, of: dateLabel, withOffset: 180)
			
			aircraft.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 10)
			aircraft.autoPinEdge(.left, to: .left, of: aircraftLabel)
			
			rigLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 40)
			rigLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			
			typeLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
			typeLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 40)
			
			heightUnitLabel.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 40)
			heightUnitLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			
			cutawayLabel.autoPinEdge(.left, to: .left, of: typeLabel)
			cutawayLabel.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 40)
			
			exitAltitudeLabel.autoPinEdge(.top, to: .bottom, of: heightUnitLabel, withOffset: 40)
			exitAltitudeLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			
			exitAlt.autoPinEdge(.top, to: .bottom, of: exitAltitudeLabel, withOffset: 4)
			exitAlt.autoPinEdge(.left, to: .left, of: exitAltitudeLabel)
			exitAlt.autoSetDimensions(to: CGSize(width: 100, height: 31))

			deployAltitudeLabel.autoPinEdge(.top, to: .top, of: exitAltitudeLabel)
			deployAltitudeLabel.autoCenterInSuperview()
			
			deployAlt.autoPinEdge(.top, to: .bottom, of: deployAltitudeLabel, withOffset: 4)
			deployAlt.autoPinEdge(.left, to: .left, of: deployAltitudeLabel)
			deployAlt.autoSetDimensions(to: CGSize(width: 100, height: 31))

			delayLabel.autoPinEdge(.top, to: .top, of: exitAltitudeLabel)
			delayLabel.autoPinEdge(.left, to: .right, of: deployAltitudeLabel, withOffset: 70)
			
			delay.autoPinEdge(.top, to: .bottom, of: delayLabel, withOffset: 4)
			delay.autoPinEdge(.left, to: .left, of: delayLabel)
			delay.autoSetDimensions(to: CGSize(width: 100, height: 31))

			descriptionLabel.autoPinEdge(.top, to: .bottom, of: exitAltitudeLabel, withOffset: 50)
			descriptionLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)

			descriptionInput.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			descriptionInput.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 4)
			descriptionInput.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 10, height: 150))
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	func tapResponse(recognizer: UITapGestureRecognizer) {
		print("tap")
		aircraft.show()
	}
}
