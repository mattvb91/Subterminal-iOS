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
	
	var dropzoneId: Int?
	
	var aircraftSelectedLabel = UILabel()
	var typeSelectedLabel = UILabel()

	var exitAlt = UITextField()
	var deployAlt = UITextField()
	var delay = UITextField()
	
	var cutaway = UISwitch()
	
	var descriptionInput = UITextView()
	
	var datePicker = GMDatePicker()
	var dateSelectedLabel = UILabel()
	
	var dropzone = SearchTextField()
	
	var heightUnit = HeightUnitView()
	
	var scrollView = UIScrollView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		exitAlt.setBottomBorder()
		exitAlt.placeholder = "13000"
		deployAlt.setBottomBorder()
		deployAlt.placeholder = "3000"
		delay.setBottomBorder()
		delay.placeholder = "60"
		
		datePicker.delegate = self
		datePicker.config.startDate = NSDate() as Date
		
		dateSelectedLabel.text = DateHelper.dateToString(date: Date())
		scrollView.addSubview(dateSelectedLabel)

		dropzone.placeholder = "Search dropzones..."
		dropzone.filterItems(Dropzone.getOptionsForSelect())
		dropzone.maxNumberOfResults = 10
		dropzone.maxResultsListHeight = 200
		dropzone.clearButtonMode = UITextFieldViewMode.whileEditing
		dropzone.accessibilityTraits = UIAccessibilityTraits.allZeros
		dropzone.itemSelectionHandler = { item in
			self.dropzone.text = item.title
			self.dropzoneId = Int(item.subtitle!)!
		}
		
		scrollView.addSubview(dropzone)
		
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
		
		exitAlt.keyboardType = UIKeyboardType.numberPad
		deployAlt.keyboardType = UIKeyboardType.numberPad
		delay.keyboardType = UIKeyboardType.numberPad

		scrollView.addSubview(aircraft)
		scrollView.addSubview(typeSelectedLabel)
		
		scrollView.addSubview(dropzoneLabel)
		scrollView.addSubview(aircraftSelectedLabel)
		scrollView.addSubview(dateLabel)
		scrollView.addSubview(aircraftLabel)
		scrollView.addSubview(rigLabel)
		scrollView.addSubview(typeLabel)
		scrollView.addSubview(heightUnitLabel)
		scrollView.addSubview(cutawayLabel)
		scrollView.addSubview(exitAltitudeLabel)
		scrollView.addSubview(deployAltitudeLabel)
		scrollView.addSubview(delayLabel)
		scrollView.addSubview(descriptionLabel)
		
		scrollView.addSubview(heightUnit)
		
		scrollView.addSubview(exitAlt)
		scrollView.addSubview(deployAlt)
		scrollView.addSubview(delay)
		
		scrollView.addSubview(cutaway)
		scrollView.addSubview(descriptionInput)
		
		self.addSubview(scrollView)
		
		setNeedsUpdateConstraints()
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
			
			dropzoneLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			dropzoneLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
			dropzoneLabel.autoSetDimensions(to: CGSize(width: 150, height: 31))
			
			dropzone.autoPinEdge(.top, to: .bottom, of: dropzoneLabel)
			dropzone.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			dropzone.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 25, height: 31))
			
			dateLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			dateLabel.autoPinEdge(.top, to: .bottom, of: dropzone, withOffset: 10)
			dateLabel.autoSetDimensions(to: CGSize(width: 100, height: 22))

			dateSelectedLabel.autoPinEdge(.left, to: .left, of: dateLabel)
			dateSelectedLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 8)
			
			aircraftLabel.autoPinEdge(.top, to: .top, of: dateLabel)
			aircraftLabel.autoPinEdge(.left, to: .right, of: dateLabel, withOffset: 120)
			
			aircraft.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 10)
			aircraft.autoPinEdge(.left, to: .left, of: aircraftLabel)
			
			aircraftSelectedLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 8)
			aircraftSelectedLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
			
			rigLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 40)
			rigLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			rigLabel.autoSetDimensions(to: CGSize(width: 100, height: 22))
			
			typeLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
			typeLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 40)
			
			typeSelectedLabel.autoPinEdge(.left, to: .left, of: typeLabel)
			typeSelectedLabel.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 8)
			
			heightUnitLabel.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 40)
			heightUnitLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			heightUnitLabel.autoSetDimensions(to: CGSize(width: 100, height: 22))
			
			heightUnit.autoPinEdge(.left, to: .left, of: heightUnitLabel)
			heightUnit.autoPinEdge(.top, to: .bottom, of: heightUnitLabel, withOffset: 8)

			cutawayLabel.autoPinEdge(.left, to: .left, of: typeLabel)
			cutawayLabel.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 40)
			
			cutaway.autoPinEdge(.top, to: .bottom, of: cutawayLabel, withOffset: 8)
			cutaway.autoPinEdge(.left, to: .left, of: cutawayLabel)

			exitAltitudeLabel.autoPinEdge(.top, to: .bottom, of: heightUnitLabel, withOffset: 50)
			exitAltitudeLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			
			exitAlt.autoPinEdge(.top, to: .bottom, of: exitAltitudeLabel, withOffset: 4)
			exitAlt.autoPinEdge(.left, to: .left, of: exitAltitudeLabel)
			exitAlt.autoSetDimensions(to: CGSize(width: 100, height: 31))

			deployAltitudeLabel.autoPinEdge(.top, to: .top, of: exitAltitudeLabel)
			deployAltitudeLabel.autoPinEdge(.left, to: .right, of: exitAlt, withOffset: 50)
			
			deployAlt.autoPinEdge(.top, to: .bottom, of: deployAltitudeLabel, withOffset: 4)
			deployAlt.autoPinEdge(.left, to: .left, of: deployAltitudeLabel)
			deployAlt.autoSetDimensions(to: CGSize(width: 100, height: 31))

			delayLabel.autoPinEdge(.top, to: .top, of: exitAltitudeLabel)
			delayLabel.autoPinEdge(.left, to: .right, of: deployAltitudeLabel, withOffset: 70)
			
			delay.autoPinEdge(.top, to: .bottom, of: delayLabel, withOffset: 4)
			delay.autoPinEdge(.left, to: .left, of: delayLabel)
			delay.autoSetDimensions(to: CGSize(width: 70, height: 31))

			descriptionLabel.autoPinEdge(.top, to: .bottom, of: exitAltitudeLabel, withOffset: 50)
			descriptionLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)

			descriptionInput.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			descriptionInput.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 4)
			descriptionInput.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 25, height: 150))
			
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
