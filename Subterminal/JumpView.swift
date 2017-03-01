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
	var contentView = UIView()
	
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

		contentView.addSubview(exitLabel)
		contentView.addSubview(rigLabel)
		contentView.addSubview(typeLabel)
		contentView.addSubview(delayLabel)
		contentView.addSubview(pcLabel)
		contentView.addSubview(sliderLabel)
		
		contentView.addSubview(exit)
		contentView.addSubview(rig)
		contentView.addSubview(type)
		contentView.addSubview(delay)
		contentView.addSubview(pc)
		contentView.addSubview(slider)

		contentView.addSubview(jumpDescription)
		
		contentView.addSubview(shadowView)
		contentView.sendSubview(toBack: shadowView)
		
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
		
		contentView.bringSubview(toFront: imageButton)
		
		let imageFullscreen = UITapGestureRecognizer(target: self, action: #selector(openImageFullscreen))
		images.addGestureRecognizer(imageFullscreen)

		scrollView.isUserInteractionEnabled = true
		scrollView.alwaysBounceVertical = true
		
		contentView.isUserInteractionEnabled = false
		
		scrollView.addSubview(contentView)
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
			contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			let size = CGSize(width: UIScreen.main.bounds.width, height: 700)
			scrollView.contentSize = size
			scrollView.autoSetDimensions(to: size)
			
			exitLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 15)
			exitLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20)
			
			exit.autoPinEdge(.left, to: .right, of: exitLabel, withOffset: 40)
			exit.autoPinEdge(.top, to: .top, of: exitLabel)
			
			rigLabel.autoPinEdge(.top, to: .bottom, of: exitLabel, withOffset: 15)
			rigLabel.autoPinEdge(.left, to: .left, of: exitLabel)
			
			rig.autoPinEdge(.top, to: .top, of: rigLabel)
			rig.autoPinEdge(.left, to: .left, of: exit)
			
			typeLabel.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 15)
			typeLabel.autoPinEdge(.left, to: .left, of: exitLabel)
			
			type.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 10)
			type.autoPinEdge(.left, to: .left, of: typeLabel, withOffset: 20)
			
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

			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 75)
			shadowView.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
			shadowView.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: jumpDescription, withOffset: 20)

			imageButton.autoPinEdge(.top, to: .bottom, of: shadowView, withOffset: 20)
			imageButton.autoPinEdge(.left, to: .left, of: exitLabel)
			imageButton.autoSetDimensions(to: CGSize(width: 100, height: 30))
			
			if images.superview === contentView {
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
