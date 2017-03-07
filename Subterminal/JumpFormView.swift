//
//  JumpFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 01/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import ElValidator
import SearchTextField
import DropDown

class JumpFormView: UIView, GMDatePickerDelegate {
	
	var didSetupConstraints: Bool = false
	var scrollView = UIScrollView.newAutoLayout()
	
	var exitLabel = Label(text: "Exit")
	var dateLabel = Label(text: "Date")
	var typeLabel = Label(text: "Type")
	var pcLabel = Label(text: "Pilot Chute")
	var sliderLabel = Label(text: "Slider")
	var rigLabel = Label(text: "Rig")
	var delayLabel = Label(text: "Delay")
	var descriptionLabel = Label(text: "Description")
	
	var date = UILabel()
	var delay = UITextField()
	
	var type = UILabel()
	var pc = UILabel()
	var slider = UILabel()
	var rig = UILabel()
	
	var arrowImage = UIImage(named: "arrow_down")
	var typeArrow = UIImageView()
	var pcArrow = UIImageView()
	var sliderArrow = UIImageView()
	var rigArrow = UIImageView()
	var dateArrow = UIImageView()

	var typeDropdown = DropDown()
	var pcDropdown = DropDown()
	var sliderDropdown = DropDown()
	var rigDropdown = DropDown()
	
	var datePicker = GMDatePicker()

	var jumpDescription = UITextView()
	
	var exit = SearchTextField()
	var exitId: Int?
	
	var sliderConfiguration: Int?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		datePicker.delegate = self
		datePicker.config.startDate = NSDate() as Date
		
		exit.placeholder = "Search exits..."
		exit.filterItems(Exit.getOptionsForSelect())
		exit.maxNumberOfResults = 10
		exit.maxResultsListHeight = 200
		exit.clearButtonMode = UITextFieldViewMode.whileEditing
		exit.accessibilityTraits = UIAccessibilityTraits.allZeros
		exit.itemSelectionHandler = { item in
			self.exit.text = item.title
			self.exitId = Int(item.subtitle!)!
		}
		exit.autocorrectionType = UITextAutocorrectionType.no
		
		jumpDescription.layer.borderColor = UIColor.gray.cgColor
		jumpDescription.layer.borderWidth = 1
		jumpDescription.layer.cornerRadius = 5
		jumpDescription.font = UIFont.systemFont(ofSize: 16)
		
		date.text = DateHelper.dateToString(date: Date())
		
		let dateGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapDate))
		dateGesture.numberOfTapsRequired = 1
		date.isUserInteractionEnabled =  true
		date.addGestureRecognizer(dateGesture)

		delay.setBottomBorder()
		delay.keyboardType = UIKeyboardType.numberPad
		delay.placeholder = "5"
		
		typeArrow.image = arrowImage
		pcArrow.image = arrowImage
		sliderArrow.image = arrowImage
		rigArrow.image = arrowImage
		dateArrow.image = arrowImage

		scrollView.addSubview(typeArrow)
		scrollView.addSubview(pcArrow)
		scrollView.addSubview(sliderArrow)
		scrollView.addSubview(rigArrow)
		scrollView.addSubview(dateArrow)

		scrollView.addSubview(exit)
		
		scrollView.addSubview(exitLabel)
		scrollView.addSubview(dateLabel)
		scrollView.addSubview(typeLabel)
		scrollView.addSubview(pcLabel)
		scrollView.addSubview(sliderLabel)
		scrollView.addSubview(rigLabel)
		scrollView.addSubview(delayLabel)
		scrollView.addSubview(descriptionLabel)
		
		scrollView.addSubview(date)
		scrollView.addSubview(delay)
		scrollView.addSubview(jumpDescription)
		
		typeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
			self.type.text = item
		}
		
		let typeGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapType))
		typeGesture.numberOfTapsRequired = 1
		type.isUserInteractionEnabled =  true
		type.addGestureRecognizer(typeGesture)
		typeDropdown.dataSource = Jump.getTypesForSelect()
		typeDropdown.anchorView = type
		
		pc.text = "36"
		pcDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
			self.pc.text = item
		}
		
		let pcGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapPc))
		pcGesture.numberOfTapsRequired = 1
		pc.isUserInteractionEnabled =  true
		pc.addGestureRecognizer(pcGesture)
		pcDropdown.dataSource = Jump.pc_sizes
		pcDropdown.anchorView = pc
		pcDropdown.selectRow(at: 1)
		
		sliderDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
			self.slider.text = item
		}
		
		let sliderGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapSlider))
		sliderGesture.numberOfTapsRequired = 1
		slider.isUserInteractionEnabled =  true
		slider.addGestureRecognizer(sliderGesture)
		sliderDropdown.dataSource = Jump.getSliderConfigForDropdown()
		sliderDropdown.anchorView = slider

		rig.text = "- Select - "

		scrollView.addSubview(type)
		scrollView.addSubview(pc)
		scrollView.addSubview(slider)
		scrollView.addSubview(rig)

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
			
			let textFieldSize = CGSize(width: 120, height: 31)

			exitLabel.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)
			exitLabel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 10)
			
			exit.autoPinEdge(.left, to: .left, of: exitLabel)
			exit.autoPinEdge(.top, to: .bottom, of: exitLabel, withOffset: 8)
			exit.autoSetDimensions(to: CGSize(width: 200, height: 31))

			dateLabel.autoPinEdge(.left, to: .right, of: exitLabel, withOffset: 200)
			dateLabel.autoPinEdge(.top, to: .top, of: exitLabel)
			
			date.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 8)
			date.autoPinEdge(.left, to: .left, of: dateLabel)
			date.autoSetDimensions(to: textFieldSize)
			dateArrow.autoPinEdge(.top, to: .top, of: date, withOffset: 8)
			dateArrow.autoPinEdge(.left, to: .right, of: date, withOffset: 5)
			
			typeLabel.autoPinEdge(.top, to: .bottom, of: exitLabel, withOffset: 60)
			typeLabel.autoPinEdge(.left, to: .left, of: exitLabel)
			
			type.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 8)
			type.autoPinEdge(.left, to: .left, of: typeLabel)
			typeArrow.autoPinEdge(.top, to: .top, of: type, withOffset: 8)
			typeArrow.autoPinEdge(.left, to: .right, of: type, withOffset: 5)
			
			pcLabel.autoPinEdge(.left, to: .right, of: typeLabel, withOffset: 80)
			pcLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			pc.autoPinEdge(.top, to: .bottom, of: pcLabel, withOffset: 8)
			pc.autoPinEdge(.left, to: .left, of: pcLabel)
			pcArrow.autoPinEdge(.top, to: .top, of: pc, withOffset: 8)
			pcArrow.autoPinEdge(.left, to: .right, of: pc, withOffset: 5)
			
			sliderLabel.autoPinEdge(.left, to: .right, of: pcLabel, withOffset: 80)
			sliderLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			slider.autoPinEdge(.top, to: .bottom, of: sliderLabel, withOffset: 8)
			slider.autoPinEdge(.left, to: .left, of: sliderLabel)
			sliderArrow.autoPinEdge(.top, to: .top, of: slider, withOffset: 8)
			sliderArrow.autoPinEdge(.left, to: .right, of: slider, withOffset: 5)

			rigLabel.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 50)
			rigLabel.autoPinEdge(.left, to: .left, of: typeLabel)
			
			rig.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 8)
			rig.autoPinEdge(.left, to: .left, of: rigLabel)
			rigArrow.autoPinEdge(.top, to: .top, of: rig, withOffset: 8)
			rigArrow.autoPinEdge(.left, to: .right, of: rig, withOffset: 5)

			delayLabel.autoPinEdge(.top, to: .top, of: rigLabel)
			delayLabel.autoPinEdge(.left, to: .right, of: rigLabel, withOffset: 200)
			
			delay.autoPinEdge(.top, to: .bottom, of: delayLabel, withOffset: 8)
			delay.autoPinEdge(.left, to: .left, of: delayLabel)
			delay.autoSetDimensions(to: textFieldSize)
			
			descriptionLabel.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 50)
			descriptionLabel.autoPinEdge(.left, to: .left, of: rigLabel)
			
			jumpDescription.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 8)
			jumpDescription.autoPinEdge(.left, to: .left, of: descriptionLabel)
			jumpDescription.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 25, height: 150))

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	func tapType(recognizer: UITapGestureRecognizer) {
		typeDropdown.show()
	}
	
	func tapPc(recognizer: UITapGestureRecognizer) {
		pcDropdown.show()
	}
	
	func tapSlider(recognizer: UITapGestureRecognizer) {
		sliderDropdown.show()
	}

	func tapDate(recognizer: UITapGestureRecognizer) {
		datePicker.show(inVC: (self.window?.rootViewController)!)
	}
	
	func gmDatePicker(_ gmDatePicker: GMDatePicker, didSelect date: Date) {
		self.date.text = DateHelper.dateToString(date: date)
	}
	
	func gmDatePickerDidCancelSelection(_ gmDatePicker: GMDatePicker) {
		// Do something then user tapped the cancel button
	}
}
