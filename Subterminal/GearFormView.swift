//
//  GearFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 14/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import ElValidator

class GearFormView: UIView, UITextFieldDelegate {
	
	var didSetupConstraints: Bool = false
	var requiredBlock:((_: [Error]) -> Void)?

	//MARK: Properties
	var containerManufacturer = TextFieldValidator()
	var containerModel = UITextField()
	var containerSerial = UITextField()
	var containerDateInUse = UITextField()
	
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
	
	var mainManufacturer = TextFieldValidator()
	var mainModel = UITextField()
	var mainSerial = UITextField()
	var mainDateInUse = UITextField()
	
	var reserveTitle = UILabel()
	var labelReserveManufacturer = Label(text: "Manufacturer")
	var labelReserveModel = Label(text: "Model")
	var labelReserveSerial = Label(text: "Serial")
	var labelReserveDateInUse = Label(text: "Date in Use")
	
	var reserveManufacturer = TextFieldValidator()
	var reserveModel = UITextField()
	var reserveSerial = UITextField()
	var reserveDateInUse = UITextField()
	
	var aadTitle = UILabel()
	var labelAadManufacturer = Label(text: "Manufacturer")
	var labelAadModel = Label(text: "Model")
	var labelAadSerial = Label(text: "Serial")
	var labelAadDateInUse = Label(text: "Date in Use")
	
	var aadManufacturer = TextFieldValidator()
	var aadModel = UITextField()
	var aadSerial = UITextField()
	var aadDateInUse = UITextField()
	
	var scrollView = UIScrollView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		requiredBlock = { [weak self] (errors: [Error]) -> Void in
			if errors.first != nil {
				self?.containerManufacturer.layer.shadowColor = UIColor.red.cgColor
			} else {
				self?.containerManufacturer.layer.shadowColor = UIColor.gray.cgColor
			}
		}
		
		containerManufacturer.delegate = self
		containerManufacturer.add(validator: LenghtValidator(validationEvent: .perCharacter, min: 1))
		containerManufacturer.validationBlock = requiredBlock

		containerTitle.text = "Container"
		containerTitle.font = UIFont.boldSystemFont(ofSize: 16)
		containerManufacturer.setBottomBorder()
		containerModel.setBottomBorder()
		containerSerial.setBottomBorder()
		containerDateInUse.setBottomBorder()
		
		containerManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		containerModel.clearButtonMode = UITextFieldViewMode.whileEditing
		containerSerial.clearButtonMode = UITextFieldViewMode.whileEditing
		
		mainTitle.text = "Main"
		mainTitle.font = UIFont.boldSystemFont(ofSize: 16)
		mainManufacturer.setBottomBorder()
		mainModel.setBottomBorder()
		mainSerial.setBottomBorder()
		mainDateInUse.setBottomBorder()
		
		mainManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		mainModel.clearButtonMode = UITextFieldViewMode.whileEditing
		mainSerial.clearButtonMode = UITextFieldViewMode.whileEditing

		reserveTitle.text = "Reserve"
		reserveTitle.font = UIFont.boldSystemFont(ofSize: 16)
		reserveManufacturer.setBottomBorder()
		reserveModel.setBottomBorder()
		reserveSerial.setBottomBorder()
		reserveDateInUse.setBottomBorder()
		
		reserveManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		reserveModel.clearButtonMode = UITextFieldViewMode.whileEditing
		reserveSerial.clearButtonMode = UITextFieldViewMode.whileEditing

		aadTitle.text = "AAD"
		aadTitle.font = UIFont.boldSystemFont(ofSize: 16)
		aadManufacturer.setBottomBorder()
		aadModel.setBottomBorder()
		aadSerial.setBottomBorder()
		aadDateInUse.setBottomBorder()
		
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
		
			let textFieldSize = CGSize(width: 180, height: 31)
			
			//Container
			containerTitle.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			
			labelContainerManufacturer.autoPinEdge(.top, to: .bottom, of: containerTitle, withOffset: 8)
			labelContainerManufacturer.autoPinEdge(.left, to: .left, of: containerTitle)
			
			labelContainerModel.autoPinEdge(.left, to: .right, of: labelContainerManufacturer, withOffset: 100)
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
			
			labelMainModel.autoPinEdge(.left, to: .right, of: labelMainManufacturer, withOffset: 100)
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
			
			labelReserveModel.autoPinEdge(.left, to: .right, of: labelReserveManufacturer, withOffset: 100)
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
			
			labelAadModel.autoPinEdge(.left, to: .right, of: labelAadManufacturer, withOffset: 100)
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
}
