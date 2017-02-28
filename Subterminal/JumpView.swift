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
import MapKit

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
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		exitLabel.text = "Exit:"
		rigLabel.text = "Rig:"
		typeLabel.text = "Type:"
		delayLabel.text = "Delay:"
		pcLabel.text = "PC:"
		sliderLabel.text = "Slider:"
		
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

		contentView.addSubview(shadowView)
		contentView.sendSubview(toBack: shadowView)

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
			contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
			
			let size = CGSize(width: UIScreen.main.bounds.width, height: 1000)
			scrollView.contentSize = size
			scrollView.autoSetDimensions(to: size)
			
			exitLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 20)
			exitLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20)
			
			rigLabel.autoPinEdge(.top, to: .bottom, of: exitLabel, withOffset: 15)
			rigLabel.autoPinEdge(.left, to: .left, of: exitLabel)
			
			typeLabel.autoPinEdge(.top, to: .bottom, of: rigLabel, withOffset: 15)
			typeLabel.autoPinEdge(.left, to: .left, of: exitLabel)
			
			delayLabel.autoPinEdge(.left, to: .right, of: typeLabel, withOffset: 60)
			delayLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			pcLabel.autoPinEdge(.left, to: .right, of: delayLabel, withOffset: 60)
			pcLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			sliderLabel.autoPinEdge(.left, to: .right, of: pcLabel, withOffset: 60)
			sliderLabel.autoPinEdge(.top, to: .top, of: typeLabel)
			
			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: sliderLabel, withOffset: 10)
			shadowView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 8)
			shadowView.autoPinEdge(.right, to: .right, of: contentView, withOffset: -8)
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
