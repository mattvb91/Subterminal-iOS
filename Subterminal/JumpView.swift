//
//  JumpView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import ImageSlideshow
import ImagePicker

class JumpView: UIView {
	var jump: Jump!
	
	var didSetupConstraints: Bool = false
	var shadowView = ShadowView()
	
	var scrollView = UIScrollView.newAutoLayout()
	
	var exitLabel = UILabel()
	var rigLabel = UILabel()
	var typeLabel = UILabel()
	var delayLabel = UILabel()
	var pcLabel = UILabel()
	var sliderLabel = UILabel()
	
	var exit = UILabel()
	var rig = UILabel()
	var type = UILabel()
	var delay = UILabel()
	var pc = UILabel()
	var slider = UILabel()
	
	var images = ImageSlideshow()
	var imageButton = UIButton(type: UIButtonType.roundedRect)
	
	var jumpDescription = UITextView.newAutoLayout()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		exitLabel.text = "Exit:"
		rigLabel.text = "Rig:"
		typeLabel.text = "Type:"
		delayLabel.text = "Delay:"
		pcLabel.text = "PC:"
		sliderLabel.text = "Slider:"
		
		jumpDescription.isScrollEnabled = false
		jumpDescription.isUserInteractionEnabled = false
		jumpDescription.font = UIFont.systemFont(ofSize: 16)
		
		exitLabel.font = UIFont.boldSystemFont(ofSize: 15)
		rigLabel.font = UIFont.boldSystemFont(ofSize: 15)
		typeLabel.font = UIFont.boldSystemFont(ofSize: 15)
		delayLabel.font = UIFont.boldSystemFont(ofSize: 15)
		pcLabel.font = UIFont.boldSystemFont(ofSize: 15)
		sliderLabel.font = UIFont.boldSystemFont(ofSize: 15)

		scrollView.addSubview(exitLabel)
		scrollView.addSubview(rigLabel)
		scrollView.addSubview(typeLabel)
		scrollView.addSubview(delayLabel)
		scrollView.addSubview(pcLabel)
		scrollView.addSubview(sliderLabel)
		
		exit.textColor = self.tintColor
		
		scrollView.addSubview(exit)
		scrollView.addSubview(rig)
		scrollView.addSubview(type)
		scrollView.addSubview(delay)
		scrollView.addSubview(pc)
		scrollView.addSubview(slider)

		scrollView.addSubview(jumpDescription)
		
		scrollView.addSubview(shadowView)
		scrollView.sendSubview(toBack: shadowView)
		
		let exitTap = UITapGestureRecognizer(target: self, action: #selector(openExit))
		exit.isUserInteractionEnabled = true
		exit.addGestureRecognizer(exitTap)
		
		imageButton.setTitle("Add Image", for: .normal)
		let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageSelect))
		imageButton.isUserInteractionEnabled = true
		imageButton.layer.borderWidth = 1
		imageButton.layer.cornerRadius = 5
		imageButton.layer.borderColor = UIColor.lightGray.cgColor
		imageButton.addGestureRecognizer(imageTap)
		imageTap.cancelsTouchesInView = false
		scrollView.addSubview(imageButton)

		images.contentScaleMode = UIViewContentMode.scaleAspectFill
		images.slideshowInterval = 5
		
		scrollView.bringSubview(toFront: imageButton)
		
		let imageFullscreen = UITapGestureRecognizer(target: self, action: #selector(openImageFullscreen))
		images.addGestureRecognizer(imageFullscreen)

		scrollView.isUserInteractionEnabled = true
		scrollView.alwaysBounceVertical = true
		
		self.addSubview(scrollView)
		self.setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func openExit(sender:UITapGestureRecognizer) {
		let exitController = ExitViewController()
		exitController.item = self.jump.exit()
		superview?.viewController()?.navigationController?.show(exitController, sender: nil)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			let size = CGSize(width: UIScreen.main.bounds.width, height: 700)
			scrollView.contentSize = size
			scrollView.autoSetDimensions(to: size)
			
			exitLabel.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 15)
			exitLabel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 20)
			
			exit.autoPinEdge(.left, to: .right, of: exitLabel, withOffset: 40)
			exit.autoPinEdge(.top, to: .top, of: exitLabel)
			
			rigLabel.autoPinEdge(.top, to: .bottom, of: exitLabel, withOffset: 15)
			rigLabel.autoPinEdge(.left, to: .left, of: exitLabel)
			
			rig.autoPinEdge(.top, to: .top, of: rigLabel)
			rig.autoPinEdge(.left, to: .left, of: exit)
			
			typeLabel.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 15)
			typeLabel.autoPinEdge(.left, to: .left, of: exitLabel)
			
			type.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 10)
			type.autoPinEdge(.left, to: .left, of: typeLabel)
			
			delayLabel.autoPinEdge(.left, to: .right, of: typeLabel, withOffset: 60)
			delayLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			delay.autoPinEdge(.top, to: .top, of: type)
			delay.autoPinEdge(.left, to: .left, of: delayLabel, withOffset: 10)
			
			pcLabel.autoPinEdge(.left, to: .right, of: delayLabel, withOffset: 60)
			pcLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			pc.autoPinEdge(.top, to: .top, of: type)
			pc.autoPinEdge(.left, to: .left, of: pcLabel, withOffset: 5)
			
			sliderLabel.autoPinEdge(.left, to: .right, of: pcLabel, withOffset: 60)
			sliderLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			slider.autoPinEdge(.top, to: .top, of: type)
			slider.autoPinEdge(.left, to: .left, of: sliderLabel, withOffset: 10)
			
			jumpDescription.autoPinEdge(.top, to: .bottom, of: type, withOffset: 20)
			jumpDescription.autoPinEdge(.left, to: .left, of: exitLabel)
			jumpDescription.autoSetDimension(.height, toSize: jumpDescription.contentSize.height)
			jumpDescription.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 40)

			shadowView.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 5)
			shadowView.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
			shadowView.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: jumpDescription, withOffset: 20)

			imageButton.autoPinEdge(.top, to: .bottom, of: shadowView, withOffset: 20)
			imageButton.autoPinEdge(.left, to: .left, of: exitLabel)
			imageButton.autoSetDimensions(to: CGSize(width: 100, height: 30))
			
			if images.superview === scrollView {
				images.autoPinEdge(.top, to: .bottom, of: imageButton, withOffset: 20)
				images.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 240))
			}
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
	func openImageFullscreen() {
		images.presentFullScreenController(from: (self.superview?.viewController())!)
	}
	
	func imageSelect(sender:UITapGestureRecognizer) {
		debugPrint("HERE")
		let imagePickerController = ImagePickerController()
		imagePickerController.delegate = self.superview?.viewController() as! ImagePickerDelegate?
		superview?.viewController()?.present(imagePickerController, animated: true, completion: nil)
	}
	
}
