//
//  SuitFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 26/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class SuitFormView: UIView, GMDatePickerDelegate {
	
	var didSetupConstraints: Bool = false

	var scrollView = UIScrollView()

	var labelType = Label(text: "Type")
	var labelDate = Label(text: "Date In Use")
	var labelManufacturer = Label(text: "Manufacturer")
	var labelModel = Label(text: "Model")
	var labelSerial = Label(text: "Serial")

	var dateField = UILabel()
	var manufacturer = UITextField()
	var model = UITextField()
	var serial = UITextField()
	var type = UILabel()
	var typeDropdown = DropDown()
	
	var arrow = UIImageView(image: UIImage(named: "arrow_down"))
	
	var datePicker = GMDatePicker()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		datePicker.delegate = self
		datePicker.config.startDate = NSDate() as Date
		dateField.text = DateHelper.dateToString(date: Date())

		let dateGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		dateGesture.numberOfTapsRequired = 1
		dateField.isUserInteractionEnabled =  true
		dateField.addGestureRecognizer(dateGesture)

		typeDropdown.dataSource = Suit.getTypesForSelect()
		typeDropdown.anchorView = type
		
		let typeGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapType))
		typeGesture.numberOfTapsRequired = 1
		type.isUserInteractionEnabled =  true
		type.addGestureRecognizer(typeGesture)
		
		typeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
			self.type.text = item
		}
		
		scrollView.addSubview(labelType)
		scrollView.addSubview(labelDate)
		scrollView.addSubview(labelManufacturer)
		scrollView.addSubview(labelModel)
		scrollView.addSubview(labelSerial)
		scrollView.addSubview(type)
		scrollView.addSubview(arrow)
		
		manufacturer.setBottomBorder()
		model.setBottomBorder()
		serial.setBottomBorder()

		manufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		model.clearButtonMode = UITextFieldViewMode.whileEditing
		serial.clearButtonMode = UITextFieldViewMode.whileEditing

		scrollView.addSubview(dateField)
		scrollView.addSubview(manufacturer)
		scrollView.addSubview(model)
		scrollView.addSubview(serial)
		
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
			
			let textFieldSize = CGSize(width: 160, height: 31)
			
			labelType.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 10)
			labelType.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 10)
			
			type.autoPinEdge(.left, to: .left, of: labelType)
			type.autoPinEdge(.top, to: .bottom, of: labelType, withOffset: 8)
			
			arrow.autoPinEdge(.left, to: .right, of: type, withOffset: 5)
			arrow.autoPinEdge(.top, to: .top, of: type, withOffset: 10)
			
			labelDate.autoPinEdge(.top, to: .top, of: labelType)
			labelDate.autoPinEdge(.left, to: .right, of: labelType, withOffset: 160)
			
			dateField.autoPinEdge(.left, to: .left, of: labelDate)
			dateField.autoPinEdge(.top, to: .bottom, of: labelDate, withOffset: 8)
			
			labelManufacturer.autoPinEdge(.top, to: .bottom, of: labelType, withOffset: 50)
			labelManufacturer.autoPinEdge(.left, to: .left, of: labelType)
			
			manufacturer.autoPinEdge(.top, to: .bottom, of: labelManufacturer, withOffset: 8)
			manufacturer.autoPinEdge(.left, to: .left, of: labelManufacturer)
			manufacturer.autoSetDimensions(to: textFieldSize)
			
			labelModel.autoPinEdge(.left, to: .left, of: labelDate)
			labelModel.autoPinEdge(.top, to: .top, of: labelManufacturer)
			
			model.autoPinEdge(.left, to: .left, of: labelModel)
			model.autoPinEdge(.top, to: .top, of: manufacturer)
			model.autoSetDimensions(to: textFieldSize)
			
			labelSerial.autoPinEdge(.left, to: .left, of: labelManufacturer)
			labelSerial.autoPinEdge(.top, to: .bottom, of: manufacturer, withOffset: 20)
			
			serial.autoPinEdge(.top, to: .bottom, of: labelSerial, withOffset: 8)
			serial.autoPinEdge(.left, to: .left, of: labelSerial)
			serial.autoSetDimensions(to: textFieldSize)
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	func tapType(recognizer: UITapGestureRecognizer) {
		self.typeDropdown.show()
	}
	
	func tapDate(recognizer: UITapGestureRecognizer) {
		datePicker.show(inVC: (self.window?.rootViewController)!)
	}
	
	func gmDatePicker(_ gmDatePicker: GMDatePicker, didSelect date: Date) {
		dateField.text = DateHelper.dateToString(date: date)
	}
	
	func gmDatePickerDidCancelSelection(_ gmDatePicker: GMDatePicker) {
		// Do something then user tapped the cancel button
	}
}
