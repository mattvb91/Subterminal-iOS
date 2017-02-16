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
	
	var labelContainerManufacturer = UILabel()
	var labelContainerModel = UILabel()
	var labelContainerSerial = UILabel()
	var labelContainerDateInUse = UILabel()
	
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
		
		labelContainerManufacturer.text = "Manufacturer"
		labelContainerModel.text = "Model"
		labelContainerSerial.text = "Serial"
		labelContainerDateInUse.text = "Date in use"
	
		containerManufacturer.delegate = self
		containerManufacturer.add(validator: LenghtValidator(validationEvent: .perCharacter, min: 1))
		containerManufacturer.validationBlock = requiredBlock

		containerManufacturer.setBottomBorder()
		containerModel.setBottomBorder()
		containerSerial.setBottomBorder()
		containerDateInUse.setBottomBorder()
		
		containerManufacturer.clearButtonMode = UITextFieldViewMode.whileEditing
		containerModel.clearButtonMode = UITextFieldViewMode.whileEditing
		containerSerial.clearButtonMode = UITextFieldViewMode.whileEditing
		
		self.addSubview(containerManufacturer)
		self.addSubview(containerModel)
		self.addSubview(containerSerial)
		self.addSubview(containerDateInUse)
		
		self.addSubview(labelContainerManufacturer)
		self.addSubview(labelContainerModel)
		self.addSubview(labelContainerSerial)
		self.addSubview(labelContainerDateInUse)

		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
		
			let textFieldSize = CGSize(width: 180, height: 31)
			
			labelContainerManufacturer.autoPinEdge(toSuperviewEdge: .top, withInset: 80)
			labelContainerManufacturer.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			
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

			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
