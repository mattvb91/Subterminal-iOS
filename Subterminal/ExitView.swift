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
	
	var detailView = UIView()
	
	var scrollView = UIScrollView()
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
	
	var difficultyTrackingExit = UILabel()
	var difficultyTrackingExitValue = UILabel()
	var difficultyTrackingFreefall = UILabel()
	var difficultyTrackingFreefallValue = UILabel()
	var difficultyTrackingLanding = UILabel()
	var difficultyTrackingLandingValue = UILabel()
	var difficultyTrackingOverall = UILabel()
	var difficultyTrackingOverallValue = UILabel()
	
	var difficultyWingsuitExit = UILabel()
	var difficultyWingsuitExitValue = UILabel()
	var difficultyWingsuitFreefall = UILabel()
	var difficultyWingsuitFreefallValue = UILabel()
	var difficultyWingsuitLanding = UILabel()
	var difficultyWingsuitLandingValue = UILabel()
	var difficultyWingsuitOverall = UILabel()
	var difficultyWingsuitOverallValue = UILabel()

	var map = MKMapView()
	
	var trackingTitle = UILabel()
	var wingsuitTitle = UILabel()
	
	var detailShadowView = ShadowView()
	
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
		
		trackingTitle.text = "Difficulty Tracking"
		trackingTitle.font = UIFont.boldSystemFont(ofSize: 14)
		
		wingsuitTitle.text = "Difficulty Wingsuit"
		wingsuitTitle.font = UIFont.boldSystemFont(ofSize: 14)
		
		difficultyTrackingExit.text = "Exit:"
		difficultyTrackingFreefall.text = "Freefall:"
		difficultyTrackingLanding.text = "Landing:"
		difficultyTrackingOverall.text = "Overall:"
		
		difficultyWingsuitExit.text = "Exit:"
		difficultyWingsuitFreefall.text = "Freefall:"
		difficultyWingsuitLanding.text = "Landing:"
		difficultyWingsuitOverall.text = "Overall:"

		detailView.addSubview(detailShadowView)
		detailView.addSubview(trackingTitle)
		detailView.addSubview(wingsuitTitle)
		
		detailView.addSubview(difficultyTrackingExit)
		detailView.addSubview(difficultyTrackingExitValue)
		detailView.addSubview(difficultyTrackingFreefall)
		detailView.addSubview(difficultyTrackingFreefallValue)
		detailView.addSubview(difficultyTrackingLanding)
		detailView.addSubview(difficultyTrackingLandingValue)
		detailView.addSubview(difficultyTrackingOverall)
		detailView.addSubview(difficultyTrackingOverallValue)

		detailView.addSubview(difficultyWingsuitExit)
		detailView.addSubview(difficultyWingsuitExitValue)
		detailView.addSubview(difficultyWingsuitFreefall)
		detailView.addSubview(difficultyWingsuitFreefallValue)
		detailView.addSubview(difficultyWingsuitLanding)
		detailView.addSubview(difficultyWingsuitLandingValue)
		detailView.addSubview(difficultyWingsuitOverall)
		detailView.addSubview(difficultyWingsuitOverallValue)
		
		contentView.addSubview(detailView)
		contentView.addSubview(map)
		contentView.sendSubview(toBack: shadowView)

		scrollView.alwaysBounceVertical = true
		scrollView.isScrollEnabled = true
		scrollView.isUserInteractionEnabled = true
		contentView.isUserInteractionEnabled = true
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
			
			if detailView.superview == contentView {
				let size = CGSize(width: UIScreen.main.bounds.width, height: 900)
				scrollView.contentSize = size
				contentView.autoSetDimensions(to: size)
				scrollView.autoSetDimensions(to: size)
			} else {
				let size = CGSize(width: UIScreen.main.bounds.width, height: 700)
				scrollView.contentSize = size
				scrollView.autoSetDimensions(to: size)
			}
			
			rockdropLabel.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)
			rockdropLabel.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 20)
			
			rockdrop.autoPinEdge(.top, to: .top, of: rockdropLabel)
			rockdrop.autoPinEdge(.right, to: .right, of: shadowView, withOffset: -50)
			
			rockdropTimeLabel.autoPinEdge(.top, to: .bottom, of: rockdropLabel, withOffset: 5)
			rockdropTimeLabel.autoPinEdge(.left, to: .left, of: rockdropLabel)
			
			rockdropTime.autoPinEdge(.top, to: .top, of: rockdropTimeLabel)
			rockdropTime.autoPinEdge(.right, to: .right, of: rockdrop)
			
			altitudeToLandingLabel.autoPinEdge(.top, to: .bottom, of: rockdropTimeLabel, withOffset: 5)
			altitudeToLandingLabel.autoPinEdge(.left, to: .left, of: rockdropTimeLabel)
			
			altitudeToLanding.autoPinEdge(.top, to: .top, of: altitudeToLandingLabel)
			altitudeToLanding.autoPinEdge(.right, to: .right, of: rockdrop)
			
			exitInfoLabel.autoPinEdge(.top, to: .bottom, of: altitudeToLandingLabel, withOffset: 20)
			exitInfoLabel.autoPinEdge(.left, to: .left, of: altitudeToLandingLabel)
		
			exitInfo.autoPinEdge(.top, to: .bottom, of: exitInfoLabel, withOffset: 5)
			exitInfo.autoSetDimension(.height, toSize: exitInfo.contentSize.height)
			exitInfo.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 35)
			exitInfo.autoPinEdge(.left, to: .left, of: exitInfoLabel)
			
			if exitRules.superview == contentView {
				exitRulesLabel.autoPinEdge(.top, to: .bottom, of: exitInfo, withOffset: 20)
				exitRulesLabel.autoPinEdge(.left, to: .left, of: exitInfoLabel)
			
				exitRules.autoPinEdge(.top, to: .bottom, of: exitRulesLabel, withOffset: 5)
				exitRules.autoPinEdge(.left, to: .left, of: exitRulesLabel)
				exitRules.autoSetDimension(.height, toSize: exitRules.contentSize.height)
				exitRules.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 35)
				shadowView.autoPinEdge(.bottom, to: .bottom, of: exitRules, withOffset: 10)
			} else {
				shadowView.autoPinEdge(.bottom, to: .bottom, of: exitInfo, withOffset: 10)
			}
			
			shadowView.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
			shadowView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 8)
			shadowView.autoPinEdge(.right, to: .right, of: contentView, withOffset: -8)
			
			if detailView.superview == contentView {
				detailView.autoPinEdge(.top, to: .bottom, of: shadowView, withOffset: 20)
				detailView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 320))
				
				detailShadowView.autoPinEdge(.top, to: .top, of: detailView)
				detailShadowView.autoPinEdge(.bottom, to: .bottom, of: detailView)
				detailShadowView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 8)
				detailShadowView.autoPinEdge(.right, to: .right, of: contentView, withOffset: -8)
				
				trackingTitle.autoPinEdge(.top, to: .top, of: detailShadowView, withOffset: 20)
				trackingTitle.autoPinEdge(.left, to: .left, of: detailShadowView, withOffset: 20)
				
				difficultyTrackingExit.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyTrackingExit.autoPinEdge(.top, to: .bottom, of: trackingTitle, withOffset: 15)
				difficultyTrackingExitValue.autoPinEdge(.left, to: .right, of: difficultyTrackingExit, withOffset: 160)
				difficultyTrackingExitValue.autoPinEdge(.top, to: .top, of: difficultyTrackingExit)
				
				difficultyTrackingFreefall.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyTrackingFreefall.autoPinEdge(.top, to: .bottom, of: difficultyTrackingExit, withOffset: 5)
				difficultyTrackingFreefallValue.autoPinEdge(.left, to: .left, of: difficultyTrackingExitValue)
				difficultyTrackingFreefallValue.autoPinEdge(.top, to: .top, of: difficultyTrackingFreefall)
				
				difficultyTrackingLanding.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyTrackingLanding.autoPinEdge(.top, to: .bottom, of: difficultyTrackingFreefall, withOffset: 5)
				difficultyTrackingLandingValue.autoPinEdge(.left, to: .left, of: difficultyTrackingExitValue)
				difficultyTrackingLandingValue.autoPinEdge(.top, to: .top, of: difficultyTrackingLanding)

				difficultyTrackingOverall.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyTrackingOverall.autoPinEdge(.top, to: .bottom, of: difficultyTrackingLanding, withOffset: 5)
				difficultyTrackingOverallValue.autoPinEdge(.left, to: .left, of: difficultyTrackingExitValue)
				difficultyTrackingOverallValue.autoPinEdge(.top, to: .top, of: difficultyTrackingOverall)
				
				//Wingsuit difficulties
				wingsuitTitle.autoPinEdge(.top, to: .bottom, of: difficultyTrackingOverall, withOffset: 20)
				wingsuitTitle.autoPinEdge(.left, to: .left, of: trackingTitle)
				
				difficultyWingsuitExit.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyWingsuitExit.autoPinEdge(.top, to: .bottom, of: wingsuitTitle, withOffset: 15)
				difficultyWingsuitExitValue.autoPinEdge(.left, to: .left, of: difficultyTrackingExitValue)
				difficultyWingsuitExitValue.autoPinEdge(.top, to: .top, of: difficultyWingsuitExit)
				
				difficultyWingsuitFreefall.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyWingsuitFreefall.autoPinEdge(.top, to: .bottom, of: difficultyWingsuitExit, withOffset: 5)
				difficultyWingsuitFreefallValue.autoPinEdge(.left, to: .left, of: difficultyTrackingExitValue)
				difficultyWingsuitFreefallValue.autoPinEdge(.top, to: .top, of: difficultyWingsuitFreefall)
				
				difficultyWingsuitLanding.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyWingsuitLanding.autoPinEdge(.top, to: .bottom, of: difficultyWingsuitFreefall, withOffset: 5)
				difficultyWingsuitLandingValue.autoPinEdge(.left, to: .left, of: difficultyTrackingExitValue)
				difficultyWingsuitLandingValue.autoPinEdge(.top, to: .top, of: difficultyWingsuitLanding)
				
				difficultyWingsuitOverall.autoPinEdge(.left, to: .left, of: trackingTitle)
				difficultyWingsuitOverall.autoPinEdge(.top, to: .bottom, of: difficultyWingsuitLanding, withOffset: 5)
				difficultyWingsuitOverallValue.autoPinEdge(.left, to: .left, of: difficultyTrackingExitValue)
				difficultyWingsuitOverallValue.autoPinEdge(.top, to: .top, of: difficultyWingsuitOverall)
		
				map.autoPinEdge(.top, to: .bottom, of: detailView, withOffset: 20.0)
			} else {
				map.autoPinEdge(.top, to: .bottom, of: shadowView, withOffset: 20.0)
			}
			
			map.autoPinEdge(.left, to: .left, of: shadowView)
			map.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
			map.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width - 20, height: 200))

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
