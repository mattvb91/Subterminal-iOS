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
import SearchTextField

class SkydiveFormView: UIView, GMDatePickerDelegate {

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
	var type = DropDown()
	
	var aircraftSelectedLabel = UILabel()
	var typeSelectedLabel = UILabel()

	var exitAlt = UITextField()
	var deployAlt = UITextField()
	var delay = UITextField()
	
	var heightUnit = UISwitch()
	
	var descriptionInput = UITextView()
	
	var datePicker = GMDatePicker()
	var dateSelectedLabel = UILabel()
	
	var dropzone = SearchTextField()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		exitAlt.setBottomBorder()
		exitAlt.placeholder = "13000"
		deployAlt.setBottomBorder()
		deployAlt.placeholder = "3000"
		delay.setBottomBorder()
		delay.placeholder = "60"
		
		datePicker.delegate = self
		datePicker.config.startDate = NSDate() as Date
		
		dateSelectedLabel.text = DateHelper.dateToString(date: Date())
		self.addSubview(dateSelectedLabel)

		dropzone.placeholder = "Search dropzones..."
		dropzone.filterStrings(Dropzone.getOptionsForSelect())
		dropzone.maxNumberOfResults = 10
		dropzone.maxResultsListHeight = 200
		dropzone.accessibilityTraits = UIAccessibilityTraits.allZeros
		self.addSubview(dropzone)
		
		let dateGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		dateGesture.numberOfTapsRequired = 1
		dateSelectedLabel.isUserInteractionEnabled =  true
		dateSelectedLabel.addGestureRecognizer(dateGesture)
		
		descriptionInput.layer.borderColor = UIColor.gray.cgColor
		descriptionInput.layer.borderWidth = 1
		descriptionInput.layer.cornerRadius = 5

		aircraft.anchorView = aircraftSelectedLabel
		aircraft.dataSource = Aircraft.getForSelect()
		
		aircraft.selectionAction = { [unowned self] (index: Int, item: String) in
			self.aircraftSelectedLabel.text = self.aircraft.selectedItem
		}
		
		aircraftSelectedLabel.text = " - select -"
		
		let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapAircrafts))
		tapGesture.numberOfTapsRequired = 1
		aircraftSelectedLabel.isUserInteractionEnabled =  true
		aircraftSelectedLabel.addGestureRecognizer(tapGesture)
		
		typeSelectedLabel.text = " - select -"
		
		type.selectionAction = { [unowned self] (index: Int, item: String) in
			self.typeSelectedLabel.text = self.type.selectedItem
		}
		
		let typeGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapType))
		tapGesture.numberOfTapsRequired = 1
		typeSelectedLabel.isUserInteractionEnabled =  true
		typeSelectedLabel.addGestureRecognizer(typeGesture)
		type.dataSource = Skydive.getTypesForSelect()
		type.anchorView = typeSelectedLabel
		
		self.addSubview(aircraft)
		self.addSubview(typeSelectedLabel)
		
		self.addSubview(dropzoneLabel)
		self.addSubview(aircraftSelectedLabel)
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
			
			dropzone.autoPinEdge(.top, to: .bottom, of: dropzoneLabel, withOffset: 8)
			dropzone.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			dropzone.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 4, height: 31))
			
			dateLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			dateLabel.autoPinEdge(.top, to: .bottom, of: dropzoneLabel, withOffset: 40)
			
			dateSelectedLabel.autoPinEdge(.left, to: .left, of: dateLabel)
			dateSelectedLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 8)
			
			aircraftLabel.autoPinEdge(.top, to: .top, of: dateLabel)
			aircraftLabel.autoPinEdge(.left, to: .right, of: dateLabel, withOffset: 180)
			
			aircraft.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 10)
			aircraft.autoPinEdge(.left, to: .left, of: aircraftLabel)
			
			aircraftSelectedLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 8)
			aircraftSelectedLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
			
			rigLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 40)
			rigLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			
			typeLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
			typeLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 40)
			
			typeSelectedLabel.autoPinEdge(.left, to: .left, of: typeLabel)
			typeSelectedLabel.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 8)
			
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
	
	func tapAircrafts(recognizer: UITapGestureRecognizer) {
		aircraft.show()
	}
	
	func tapType(recognizer: UITapGestureRecognizer) {
		type.show()
	}
	
	func tapDate(recognizer: UITapGestureRecognizer) {
		datePicker.show(inVC: (self.window?.rootViewController)!)
	}
	
	func gmDatePicker(_ gmDatePicker: GMDatePicker, didSelect date: Date) {
		dateSelectedLabel.text = DateHelper.dateToString(date: date)
	}

	func gmDatePickerDidCancelSelection(_ gmDatePicker: GMDatePicker) {
		// Do something then user tapped the cancel button
	}
	
}
