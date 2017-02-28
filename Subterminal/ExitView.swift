//
//  ExitView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import MapKit

class ExitView: UIView {
	var exit: Exit!
	
	var didSetupConstraints: Bool = false
	var shadowView = ShadowView()
	
	var scrollView = UIScrollView.newAutoLayout()
	var contentView = UIView()
	
	var rockdropLabel = UILabel()
	var rockdropTimeLabel = UILabel()
	var altitudeToLandingLabel = UILabel()
	
	var rockdrop = UILabel()
	var rockdropTime = UILabel()
	var altitudeToLanding = UILabel()
	
	var exitInfoLabel = UILabel()
	var exitRulesLabel = UILabel()
	
	var exitInfo = UITextView()
	var exitRules = UITextView()
	
	var map = MKMapView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.white
		
		rockdropLabel.text = "Rockdrop distance:"
		rockdropTimeLabel.text = "Rockdrop time:"
		altitudeToLandingLabel.text = "Altidude to landing:"
		
		exitInfoLabel.text = "Exit Info"
		exitInfoLabel.font = UIFont.boldSystemFont(ofSize: 16)
		
		exitRulesLabel.text = "Exit Rules"
		exitRulesLabel.font = UIFont.boldSystemFont(ofSize: 16)

		exitInfo.isScrollEnabled = false
		exitInfo.isUserInteractionEnabled = false
		exitInfo.font = UIFont.systemFont(ofSize: 16)

		exitRules.isScrollEnabled = false
		exitRules.isUserInteractionEnabled = false
		exitRules.font = UIFont.systemFont(ofSize: 16)

		contentView.addSubview(rockdropLabel)
		contentView.addSubview(rockdropTimeLabel)
		contentView.addSubview(altitudeToLandingLabel)
		
		rockdrop.font = UIFont.boldSystemFont(ofSize: 16)
		rockdropTime.font = UIFont.boldSystemFont(ofSize: 16)
		altitudeToLanding.font = UIFont.boldSystemFont(ofSize: 16)

		contentView.addSubview(rockdrop)
		contentView.addSubview(rockdropTime)
		contentView.addSubview(altitudeToLanding)

		contentView.addSubview(exitInfo)
		contentView.addSubview(exitRules)
		
		contentView.addSubview(exitInfoLabel)
		contentView.addSubview(exitRulesLabel)

		contentView.addSubview(shadowView)
		contentView.sendSubview(toBack: shadowView)

		contentView.isUserInteractionEnabled = true
		scrollView.addSubview(contentView)
		
		scrollView.addSubview(map)

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
			
			rockdropLabel.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)
			rockdropLabel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 20)
			
			rockdrop.autoPinEdge(.top, to: .top, of: rockdropLabel)
			rockdrop.autoPinEdge(.right, to: .right, of: shadowView, withOffset: -25)
			
			rockdropTimeLabel.autoPinEdge(.top, to: .bottom, of: rockdropLabel, withOffset: 10)
			rockdropTimeLabel.autoPinEdge(.left, to: .left, of: rockdropLabel)
			
			rockdropTime.autoPinEdge(.top, to: .top, of: rockdropTimeLabel)
			rockdropTime.autoPinEdge(.right, to: .right, of: rockdrop)
			
			altitudeToLandingLabel.autoPinEdge(.top, to: .bottom, of: rockdropTimeLabel, withOffset: 10)
			altitudeToLandingLabel.autoPinEdge(.left, to: .left, of: rockdropTimeLabel)
			
			altitudeToLanding.autoPinEdge(.top, to: .top, of: altitudeToLandingLabel)
			altitudeToLanding.autoPinEdge(.right, to: .right, of: rockdrop)
			
			exitInfoLabel.autoPinEdge(.top, to: .bottom, of: altitudeToLandingLabel, withOffset: 20)
			exitInfoLabel.autoPinEdge(.left, to: .left, of: altitudeToLandingLabel)
		
			exitInfo.autoPinEdge(.top, to: .bottom, of: exitInfoLabel, withOffset: 10)
			exitInfo.autoSetDimension(.height, toSize: exitInfo.contentSize.height)
			exitInfo.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
			exitInfo.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			exitInfo.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			
			exitRulesLabel.autoPinEdge(.top, to: .bottom, of: exitInfo, withOffset: 20)
			exitRulesLabel.autoPinEdge(.left, to: .left, of: exitInfoLabel)

			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
			shadowView.autoPinEdge(.bottom, to: .bottom, of: exitRulesLabel, withOffset: 10)
			shadowView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 8)
			shadowView.autoPinEdge(.right, to: .right, of: contentView, withOffset: -8)
			
			map.autoPinEdge(.top, to: .bottom, of: shadowView, withOffset: 20.0)
			map.autoPinEdge(.left, to: .left, of: shadowView)
			map.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			map.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 20, height: 200))

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
