//
//  SkydiveView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 16/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import ImagePicker
import ImageSlideshow

class SkydiveView: UIView {
	
	var skydive: Skydive?
	
	var didSetupConstraints: Bool = false
	var scrollView = UIScrollView()

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
	
	var images = ImageSlideshow()
	var imageButton = UIButton(type: UIButtonType.roundedRect)
	
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
		
		imageButton.setTitle("Add Image", for: .normal)
		let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageSelect))
		imageButton.isUserInteractionEnabled = true
		imageButton.layer.borderWidth = 1
		imageButton.layer.cornerRadius = 5
		imageButton.layer.borderColor = UIColor.lightGray.cgColor
		imageButton.addGestureRecognizer(imageTap)
		scrollView.addSubview(imageButton)
		
		scrollView.addSubview(dropzoneLabel)
		scrollView.addSubview(rigLabel)
		scrollView.addSubview(aircraftLabel)
		scrollView.addSubview(typeLabel)
		scrollView.addSubview(exitAltLabel)
		scrollView.addSubview(deployAltLabel)
		scrollView.addSubview(delayLabel)
		
		scrollView.addSubview(aircraft)
		scrollView.addSubview(exitAlt)
		scrollView.addSubview(deployAlt)
		scrollView.addSubview(delay)
		scrollView.addSubview(type)
		scrollView.addSubview(dropzone)
		scrollView.addSubview(rig)

		scrollView.addSubview(skydiveDescription)
		
		scrollView.addSubview(shadowView)
		scrollView.sendSubview(toBack: shadowView)
		
		images.contentScaleMode = UIViewContentMode.scaleAspectFill
		images.slideshowInterval = 5
		
		let imageFullscreen = UITapGestureRecognizer(target: self, action: #selector(openImageFullscreen))
		images.addGestureRecognizer(imageFullscreen)
		
		scrollView.isUserInteractionEnabled = true
		scrollView.alwaysBounceVertical = true
		self.addSubview(scrollView)
		
		self.setNeedsUpdateConstraints()
	}
	
	func openImageFullscreen() {
		images.presentFullScreenController(from: (self.superview?.viewController())!)
	}
	
	func openDropzone(sender:UITapGestureRecognizer) {
		let dropzoneController = DropzoneViewController()
		dropzoneController.item = skydive?.dropzone()
		superview?.viewController()?.navigationController?.show(dropzoneController, sender: nil)
	}
	
	func imageSelect(sender:UITapGestureRecognizer) {
		let imagePickerController = ImagePickerController()
		imagePickerController.delegate = self.superview?.viewController() as! ImagePickerDelegate?
		superview?.viewController()?.present(imagePickerController, animated: true, completion: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			let size = CGSize(width: UIScreen.main.bounds.width, height: 750)
			scrollView.contentSize = size
			scrollView.autoSetDimensions(to: size)

			shadowView.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)
			shadowView.autoPinEdge(.left, to: .left, of: superview!, withOffset: 5)
			shadowView.autoPinEdge(.right, to: .right, of: superview!, withOffset: 5)
			
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
			
			deployAltLabel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: size.width / 3)
			deployAltLabel.autoPinEdge(.top, to: .top, of: exitAltLabel)
			
			deployAlt.autoPinEdge(.left, to: .left, of: deployAltLabel)
			deployAlt.autoPinEdge(.top, to: .bottom, of: deployAltLabel, withOffset: 10)

			delayLabel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: (size.width / 3) * 2)
			delayLabel.autoPinEdge(.top, to: .top, of: deployAltLabel)
			
			delay.autoPinEdge(.left, to: .left, of: delayLabel)
			delay.autoPinEdge(.top, to: .bottom, of: delayLabel, withOffset: 10)
			
			skydiveDescription.autoPinEdge(.top, to: .bottom, of: delayLabel, withOffset: 40)
			skydiveDescription.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			skydiveDescription.autoSetDimension(.height, toSize: skydiveDescription.contentSize.height)
			skydiveDescription.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 40)
			
			shadowView.autoPinEdge(.bottom, to: .bottom, of: skydiveDescription, withOffset: 20)
			
			imageButton.autoPinEdge(.top, to: .bottom, of: shadowView, withOffset: 20)
			imageButton.autoPinEdge(.left, to: .left, of: dropzoneLabel)
			imageButton.autoSetDimensions(to: CGSize(width: 100, height: 30))

			if images.superview === self {
				images.autoPinEdge(.top, to: .bottom, of: imageButton, withOffset: 20)
				images.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 240))
			}
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
