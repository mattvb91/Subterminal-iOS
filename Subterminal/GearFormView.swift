//
//  GearFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 14/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class GearFormView: UIView, UITextFieldDelegate, GMDatePickerDelegate {
	
	var didSetupConstraints: Bool = false

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
	
	var reserveTitle = UILabel()
	var labelReserveManufacturer = Label(text: "Manufacturer")
	var labelReserveModel = Label(text: "Model")
	var labelReserveSerial = Label(text: "Serial")
	var labelReserveDateInUse = Label(text: "Date in Use")
	
	var reserveManufacturer = UITextField()
	var reserveModel = UITextField()
	var reserveSerial = UITextField()
	var reserveDateInUse = UILabel()
	
	var aadTitle = UILabel()
	var labelAadManufacturer = Label(text: "Manufacturer")
	var labelAadModel = Label(text: "Model")
	var labelAadSerial = Label(text: "Serial")
	var labelAadDateInUse = Label(text: "Date in Use")
	
	var aadManufacturer = UITextField()
	var aadModel = UITextField()
	var aadSerial = UITextField()
	var aadDateInUse = UILabel()
	
	var datePicker = GMDatePicker()
	var scrollView = UIScrollView()
	
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
		
		let containerDateGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		let mainDateGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		let reserveDateGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		let aadDateGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))

		containerDateInUse.isUserInteractionEnabled =  true
		containerDateInUse.addGestureRecognizer(containerDateGesture)
		
		containerManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		containerModel.clearButtonMode = UITextFieldViewMode.whileEditing
		containerSerial.clearButtonMode = UITextFieldViewMode.whileEditing
		
		mainTitle.text = "Main"
		mainTitle.font = UIFont.boldSystemFont(ofSize: 16)
		mainManufacturer.setBottomBorder()
		mainModel.setBottomBorder()
		mainSerial.setBottomBorder()
		mainDateInUse.text = DateHelper.dateToString(date: Date())
		mainDateInUse.isUserInteractionEnabled =  true
		mainDateInUse.addGestureRecognizer(mainDateGesture)
		
		mainManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		mainModel.clearButtonMode = UITextFieldViewMode.whileEditing
		mainSerial.clearButtonMode = UITextFieldViewMode.whileEditing

		reserveTitle.text = "Reserve"
		reserveTitle.font = UIFont.boldSystemFont(ofSize: 16)
		reserveManufacturer.setBottomBorder()
		reserveModel.setBottomBorder()
		reserveSerial.setBottomBorder()
		reserveDateInUse.text = DateHelper.dateToString(date: Date())
		reserveDateInUse.isUserInteractionEnabled =  true
		reserveDateInUse.addGestureRecognizer(reserveDateGesture)

		reserveManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		reserveModel.clearButtonMode = UITextFieldViewMode.whileEditing
		reserveSerial.clearButtonMode = UITextFieldViewMode.whileEditing

		aadTitle.text = "AAD"
		aadTitle.font = UIFont.boldSystemFont(ofSize: 16)
		aadManufacturer.setBottomBorder()
		aadModel.setBottomBorder()
		aadSerial.setBottomBorder()
		aadDateInUse.text = DateHelper.dateToString(date: Date())
		aadDateInUse.isUserInteractionEnabled =  true
		aadDateInUse.addGestureRecognizer(aadDateGesture)

		aadManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		aadModel.clearButtonMode = UITextFieldViewMode.whileEditing
		aadSerial.clearButtonMode = UITextFieldViewMode.whileEditing

		self.addSubview(scrollView)
		
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

		scrollView.addSubview(reserveTitle)
		scrollView.addSubview(reserveManufacturer)
		scrollView.addSubview(reserveModel)
		scrollView.addSubview(reserveSerial)
		scrollView.addSubview(reserveDateInUse)
		
		scrollView.addSubview(labelReserveManufacturer)
		scrollView.addSubview(labelReserveModel)
		scrollView.addSubview(labelReserveSerial)
		scrollView.addSubview(labelReserveDateInUse)
		
		scrollView.addSubview(aadTitle)
		scrollView.addSubview(aadManufacturer)
		scrollView.addSubview(aadModel)
		scrollView.addSubview(aadSerial)
		scrollView.addSubview(aadDateInUse)
		
		scrollView.addSubview(labelAadManufacturer)
		scrollView.addSubview(labelAadModel)
		scrollView.addSubview(labelAadSerial)
		scrollView.addSubview(labelAadDateInUse)
		
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
			
			//Container
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
			
			//Reserve
			reserveTitle.autoPinEdge(.top, to: .bottom, of: mainSerial, withOffset:  12)
			reserveTitle.autoPinEdge(.left, to: .left, of: mainSerial)
			
			labelReserveManufacturer.autoPinEdge(.top, to: .bottom, of: reserveTitle, withOffset: 8)
			labelReserveManufacturer.autoPinEdge(.left, to: .left, of: reserveTitle)
			
			labelReserveModel.autoPinEdge(.left, to: .left, of: labelContainerModel)
			labelReserveModel.autoPinEdge(.top, to: .top, of: labelReserveManufacturer)
			
			reserveManufacturer.autoPinEdge(.top, to: .bottom, of: labelReserveManufacturer, withOffset: 8)
			reserveManufacturer.autoPinEdge(.left, to: .left, of: labelReserveManufacturer)
			reserveManufacturer.autoSetDimensions(to: textFieldSize)
			
			reserveModel.autoPinEdge(.top, to: .bottom, of: labelReserveModel, withOffset: 8)
			reserveModel.autoPinEdge(.left, to: .left, of: labelReserveModel)
			reserveModel.autoSetDimensions(to: textFieldSize)
			
			labelReserveSerial.autoPinEdge(.top, to: .bottom, of: reserveManufacturer, withOffset: 10)
			labelReserveSerial.autoPinEdge(.left, to: .left, of: reserveManufacturer)
			
			labelReserveDateInUse.autoPinEdge(.left, to: .left, of: reserveModel)
			labelReserveDateInUse.autoPinEdge(.top, to: .top, of: labelReserveSerial)
			
			reserveSerial.autoPinEdge(.top, to: .bottom, of: labelReserveSerial, withOffset: 8)
			reserveSerial.autoPinEdge(.left, to: .left, of: labelReserveSerial)
			reserveSerial.autoSetDimensions(to: textFieldSize)
			
			reserveDateInUse.autoPinEdge(.top, to: .bottom, of: labelReserveDateInUse, withOffset: 8)
			reserveDateInUse.autoPinEdge(.left, to: .left, of: labelReserveDateInUse)
			reserveDateInUse.autoSetDimensions(to: textFieldSize)

			//AAD
			aadTitle.autoPinEdge(.top, to: .bottom, of: reserveSerial, withOffset:  12)
			aadTitle.autoPinEdge(.left, to: .left, of: reserveSerial)
			
			labelAadManufacturer.autoPinEdge(.top, to: .bottom, of: aadTitle, withOffset: 8)
			labelAadManufacturer.autoPinEdge(.left, to: .left, of: aadTitle)
			
			labelAadModel.autoPinEdge(.left, to: .left, of: labelContainerModel)
			labelAadModel.autoPinEdge(.top, to: .top, of: labelAadManufacturer)
			
			aadManufacturer.autoPinEdge(.top, to: .bottom, of: labelAadManufacturer, withOffset: 8)
			aadManufacturer.autoPinEdge(.left, to: .left, of: labelAadManufacturer)
			aadManufacturer.autoSetDimensions(to: textFieldSize)
			
			aadModel.autoPinEdge(.top, to: .bottom, of: labelAadModel, withOffset: 8)
			aadModel.autoPinEdge(.left, to: .left, of: labelAadModel)
			aadModel.autoSetDimensions(to: textFieldSize)
			
			labelAadSerial.autoPinEdge(.top, to: .bottom, of: aadManufacturer, withOffset: 10)
			labelAadSerial.autoPinEdge(.left, to: .left, of: aadManufacturer)
			
			labelAadDateInUse.autoPinEdge(.left, to: .left, of: aadModel)
			labelAadDateInUse.autoPinEdge(.top, to: .top, of: labelAadSerial)
			
			aadSerial.autoPinEdge(.top, to: .bottom, of: labelAadSerial, withOffset: 8)
			aadSerial.autoPinEdge(.left, to: .left, of: labelAadSerial)
			aadSerial.autoSetDimensions(to: textFieldSize)
			
			aadDateInUse.autoPinEdge(.top, to: .bottom, of: labelAadDateInUse, withOffset: 8)
			aadDateInUse.autoPinEdge(.left, to: .left, of: labelAadDateInUse)
			aadDateInUse.autoSetDimensions(to: textFieldSize)
			
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
