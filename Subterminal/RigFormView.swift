//
//  RigFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 07/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class RigFormView: UIView, UITextFieldDelegate, GMDatePickerDelegate {
	
	var didSetupConstraints: Bool = false
	var scrollView = UIScrollView.newAutoLayout()
	var validator = FormValidator()

	//MARK: Properties
	var containerManufacturer = UITextField()
	var containerModel = UITextField()
	var containerSerial = UITextField()
	var containerDateInUse = UILabel()
	
	var containerTitle = UILabel()
	var labelContainerManufacturer = Label(text: "Manufacturer")
	var labelContainerModel = Label(text: "Model")
	var labelContainerSerial = Label(text: "Serial")
	var labelContainerDateInUse = Label(text: "Date in Use")
	
	var mainTitle = UILabel()
	var labelMainManufacturer = Label(text: "Manufacturer")
	var labelMainModel = Label(text: "Model")
	var labelMainSerial = Label(text: "Serial")
	var labelMainDateInUse = Label(text: "Date in Use")
	
	var mainManufacturer = UITextField()
	var mainModel = UITextField()
	var mainSerial = UITextField()
	var mainDateInUse = UILabel()

	var datePicker = GMDatePicker()
	var activeDateView: UIView?

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		datePicker.delegate = self
		datePicker.config.startDate = NSDate() as Date
		
		containerTitle.text = "Container"
		containerTitle.font = UIFont.boldSystemFont(ofSize: 16)
		containerManufacturer.setBottomBorder()
		containerModel.setBottomBorder()
		containerSerial.setBottomBorder()
		containerDateInUse.text = DateHelper.dateToString(date: Date())

		containerManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		containerModel.clearButtonMode = UITextFieldViewMode.whileEditing
		containerSerial.clearButtonMode = UITextFieldViewMode.whileEditing
		
		mainTitle.text = "Canopy"
		mainTitle.font = UIFont.boldSystemFont(ofSize: 16)
		mainManufacturer.setBottomBorder()
		mainModel.setBottomBorder()
		mainSerial.setBottomBorder()
		mainDateInUse.text = DateHelper.dateToString(date: Date())

		validator.addRequiredField(field: containerManufacturer)
		validator.addRequiredField(field: mainManufacturer)
		
		mainManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		mainModel.clearButtonMode = UITextFieldViewMode.whileEditing
		mainSerial.clearButtonMode = UITextFieldViewMode.whileEditing
		
		let containerDateGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		let mainDateGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		
		containerDateInUse.isUserInteractionEnabled =  true
		containerDateInUse.addGestureRecognizer(containerDateGesture)
		mainDateInUse.isUserInteractionEnabled =  true
		mainDateInUse.addGestureRecognizer(mainDateGesture)

		scrollView.addSubview(containerTitle)
		scrollView.addSubview(containerManufacturer)
		scrollView.addSubview(containerModel)
		scrollView.addSubview(containerSerial)
		scrollView.addSubview(containerDateInUse)
		
		scrollView.addSubview(labelContainerManufacturer)
		scrollView.addSubview(labelContainerModel)
		scrollView.addSubview(labelContainerSerial)
		scrollView.addSubview(labelContainerDateInUse)
		
		scrollView.addSubview(mainTitle)
		scrollView.addSubview(mainManufacturer)
		scrollView.addSubview(mainModel)
		scrollView.addSubview(mainSerial)
		scrollView.addSubview(mainDateInUse)
		
		scrollView.addSubview(labelMainManufacturer)
		scrollView.addSubview(labelMainModel)
		scrollView.addSubview(labelMainSerial)
		scrollView.addSubview(labelMainDateInUse)
		
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
			
			let textFieldSize: CGSize
			
			if Display.typeIsLike == DisplayType.iphone5 {
				textFieldSize = CGSize(width: 140, height: 31)
			} else {
				textFieldSize = CGSize(width: 180, height: 31)
			}
			
			//Container
			containerTitle.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			
			labelContainerManufacturer.autoPinEdge(.top, to: .bottom, of: containerTitle, withOffset: 8)
			labelContainerManufacturer.autoPinEdge(.left, to: .left, of: containerTitle)
			
			labelContainerModel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: size.width / 2)
			labelContainerModel.autoPinEdge(.top, to: .top, of: labelContainerManufacturer)
			
			containerManufacturer.autoPinEdge(.top, to: .bottom, of: labelContainerManufacturer, withOffset: 8)
			containerManufacturer.autoPinEdge(.left, to: .left, of: labelContainerManufacturer)
			containerManufacturer.autoSetDimensions(to: textFieldSize)
			
			containerModel.autoPinEdge(.top, to: .bottom, of: labelContainerModel, withOffset: 8)
			containerModel.autoPinEdge(.left, to: .left, of: labelContainerModel)
			containerModel.autoSetDimensions(to: textFieldSize)
			
			labelContainerSerial.autoPinEdge(.top, to: .bottom, of: containerManufacturer, withOffset: 10)
			labelContainerSerial.autoPinEdge(.left, to: .left, of: labelContainerManufacturer)
			
			labelContainerDateInUse.autoPinEdge(.left, to: .left, of: labelContainerModel)
			labelContainerDateInUse.autoPinEdge(.top, to: .top, of: labelContainerSerial)
			
			containerSerial.autoPinEdge(.top, to: .bottom, of: labelContainerSerial, withOffset: 8)
			containerSerial.autoPinEdge(.left, to: .left, of: labelContainerSerial)
			containerSerial.autoSetDimensions(to: textFieldSize)
			
			containerDateInUse.autoPinEdge(.top, to: .bottom, of: labelContainerDateInUse, withOffset: 8)
			containerDateInUse.autoPinEdge(.left, to: .left, of: labelContainerDateInUse)
			containerDateInUse.autoSetDimensions(to: textFieldSize)
			
			//Canopy
			mainTitle.autoPinEdge(.top, to: .bottom, of: containerSerial, withOffset:  12)
			mainTitle.autoPinEdge(.left, to: .left, of: containerSerial)
			
			labelMainManufacturer.autoPinEdge(.top, to: .bottom, of: mainTitle, withOffset: 8)
			labelMainManufacturer.autoPinEdge(.left, to: .left, of: mainTitle)
			
			labelMainModel.autoPinEdge(.left, to: .left, of: labelContainerModel)
			labelMainModel.autoPinEdge(.top, to: .top, of: labelMainManufacturer)
			
			mainManufacturer.autoPinEdge(.top, to: .bottom, of: labelMainManufacturer, withOffset: 8)
			mainManufacturer.autoPinEdge(.left, to: .left, of: labelMainManufacturer)
			mainManufacturer.autoSetDimensions(to: textFieldSize)
			
			mainModel.autoPinEdge(.top, to: .bottom, of: labelMainModel, withOffset: 8)
			mainModel.autoPinEdge(.left, to: .left, of: labelMainModel)
			mainModel.autoSetDimensions(to: textFieldSize)
			
			labelMainSerial.autoPinEdge(.top, to: .bottom, of: mainManufacturer, withOffset: 10)
			labelMainSerial.autoPinEdge(.left, to: .left, of: mainManufacturer)
			
			labelMainDateInUse.autoPinEdge(.left, to: .left, of: labelMainModel)
			labelMainDateInUse.autoPinEdge(.top, to: .top, of: labelMainSerial)
			
			mainSerial.autoPinEdge(.top, to: .bottom, of: labelMainSerial, withOffset: 8)
			mainSerial.autoPinEdge(.left, to: .left, of: labelMainSerial)
			mainSerial.autoSetDimensions(to: textFieldSize)
			
			mainDateInUse.autoPinEdge(.top, to: .bottom, of: labelMainDateInUse, withOffset: 8)
			mainDateInUse.autoPinEdge(.left, to: .left, of: labelMainDateInUse)
			mainDateInUse.autoSetDimensions(to: textFieldSize)
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	func tapDate(recognizer: UITapGestureRecognizer) {
		datePicker.show(inVC: (self.window?.rootViewController)!)
		
		self.activeDateView = recognizer.view
	}
	
	func gmDatePicker(_ gmDatePicker: GMDatePicker, didSelect date: Date) {
		let activeView = self.activeDateView as! UILabel
		activeView.text = DateHelper.dateToString(date: date)
	}
	
	func gmDatePickerDidCancelSelection(_ gmDatePicker: GMDatePicker) {
		// Do something then user tapped the cancel button
	}

}
