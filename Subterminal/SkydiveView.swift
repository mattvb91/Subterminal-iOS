//
//  SkydiveView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 16/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveView: UIView {
	
	var skydive: Skydive?
	
	var didSetupConstraints: Bool = false

	var shadowView = ShadowView()

	var dropzoneLabel = UILabel()
	var rigLabel = UILabel()
	var aircraftLabel = UILabel()
	var typeLabel = UILabel()
	
	var exitAltLabel = UILabel()
	var deployAltLabel = UILabel()
	var delayLabel = UILabel()
	
	var aircraft = UILabel()
	var exitAlt = UILabel()
	var deployAlt = UILabel()
	var delay = UILabel()
	var type = UILabel()
	var dropzone = UILabel()
	var rig = UILabel()
	
	var skydiveDescription = UITextView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		dropzoneLabel.text = "Dropzone:"
		dropzoneLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		rigLabel.text = "Rig:"
		rigLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		aircraftLabel.text = "Aircraft:"
		aircraftLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		typeLabel.text = "Type:"
		typeLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		exitAltLabel.text = "Exit Alt."
		exitAltLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		deployAltLabel.text = "Deploy Alt."
		deployAltLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		delayLabel.text = "Delay"
		delayLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		skydiveDescription.isScrollEnabled = false
		skydiveDescription.text = skydive?.skydive_description
		skydiveDescription.font = UIFont.systemFont(ofSize: 16)
		skydiveDescription.isUserInteractionEnabled = false
		
		dropzone.textColor = self.tintColor
		let tap = UITapGestureRecognizer(target: self, action: #selector(openDropzone))
		dropzone.isUserInteractionEnabled = true
		dropzone.addGestureRecognizer(tap)
		
		self.addSubview(dropzoneLabel)
		self.addSubview(rigLabel)
		self.addSubview(aircraftLabel)
		self.addSubview(typeLabel)
		self.addSubview(exitAltLabel)
		self.addSubview(deployAltLabel)
		self.addSubview(delayLabel)
		
		self.addSubview(aircraft)
		self.addSubview(exitAlt)
		self.addSubview(deployAlt)
		self.addSubview(delay)
		self.addSubview(type)
		self.addSubview(dropzone)
		self.addSubview(rig)

		self.addSubview(skydiveDescription)
		
		self.addSubview(shadowView)
		self.sendSubview(toBack: shadowView)
		
		self.setNeedsUpdateConstraints()
	}
	
	func openDropzone(sender:UITapGestureRecognizer) {
		let dropzoneController = DropzoneViewController()
		dropzoneController.item = skydive?.dropzone()
		superview?.viewController()?.navigationController?.show(dropzoneController, sender: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)

			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 75)
			shadowView.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
			shadowView.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
			
			dropzoneLabel.autoPinEdge(.top, to: .top, of: shadowView, withOffset: 15)
			dropzoneLabel.autoPinEdge(.left, to: .left, of: shadowView, withOffset: 10)
			
			dropzone.autoPinEdge(.left, to: .right, of: dropzoneLabel, withOffset: 40)
			dropzone.autoPinEdge(.top, to: .top, of: dropzoneLabel)

			rigLabel.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			rigLabel.autoPinEdge(.top, to: .bottom, of: dropzoneLabel, withOffset: 15)
			
			rig.autoPinEdge(.left, to: .left, of: dropzone)
			rig.autoPinEdge(.top, to: .top, of: rigLabel)
			
			aircraftLabel.autoPinEdge(.left, to: .left, of: rigLabel)
			aircraftLabel.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 15)
			
			aircraft.autoPinEdge(.left, to: .left, of: dropzone)
			aircraft.autoPinEdge(.top, to: .top, of: aircraftLabel)
			
			typeLabel.autoPinEdge(.left, to: .left, of: aircraftLabel)
			typeLabel.autoPinEdge(.top, to: .bottom, of: aircraftLabel, withOffset: 15)
			
			type.autoPinEdge(.top, to: .top, of: typeLabel)
			type.autoPinEdge(.left, to: .left, of: aircraft)
			
			exitAltLabel.autoPinEdge(.left, to: .left, of: typeLabel)
			exitAltLabel.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 15)
			
			exitAlt.autoPinEdge(.left, to: .left, of: exitAltLabel)
			exitAlt.autoPinEdge(.top, to: .bottom, of: exitAltLabel, withOffset: 10)
			
			deployAltLabel.autoPinEdge(.left, to: .right, of: exitAltLabel, withOffset: 80)
			deployAltLabel.autoPinEdge(.top, to: .top, of: exitAltLabel)
			
			deployAlt.autoPinEdge(.left, to: .left, of: deployAltLabel)
			deployAlt.autoPinEdge(.top, to: .bottom, of: deployAltLabel, withOffset: 10)

			delayLabel.autoPinEdge(.left, to: .right, of: deployAltLabel, withOffset: 80)
			delayLabel.autoPinEdge(.top, to: .top, of: deployAltLabel)
			
			delay.autoPinEdge(.left, to: .left, of: delayLabel)
			delay.autoPinEdge(.top, to: .bottom, of: delayLabel, withOffset: 10)
			
			skydiveDescription.autoPinEdge(.top, to: .bottom, of: delayLabel, withOffset: 40)
			skydiveDescription.autoSetDimension(.height, toSize: skydiveDescription.contentSize.height)
			skydiveDescription.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			skydiveDescription.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			
			shadowView.autoPinEdge(.bottom, to: .bottom, of: skydiveDescription, withOffset: 20)
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
