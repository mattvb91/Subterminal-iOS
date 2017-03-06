//
//  DashboardView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 24/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
//import FBSDKLoginKit
import Charts

class DashboardView: UIView {
	
	//var loginView = FBSDKLoginButton()
	//var premiumButton = UIButton()
	
	var scrollView = UIScrollView.newAutoLayout()
	
	var didSetupConstraints: Bool = false
	
	var shadowViewSkydives = ShadowView()
	var shadowViewBase = ShadowView()
	var shadowViewDropzones = ShadowView()
	var shadowViewExits = ShadowView()
	
	var shadowViewSkydiveStats = ShadowView()
	var shadowViewBaseStats = ShadowView()

	var skydiveCount = UILabel()
	var baseCount = UILabel()
	var dropzonesCount = UILabel()
	var exitCount = UILabel()
	
	var skydiveLabel = UILabel()
	var baseLabel = UILabel()
	var dropzoneLabel = UILabel()
	var exitLabel = UILabel()
	
	var skydiveFreefallTime = UILabel()
	var baseFreefallTime = UILabel()

	var pullheight = LineChartView()
	var exitTypes = PieChartView()
	var favouriteExits = BarChartView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = UIColor.white
		
		skydiveLabel.text = "Skydives"
		skydiveLabel.font = UIFont.boldSystemFont(ofSize: 14)
		baseLabel.text = "B.A.S.E"
		baseLabel.font = UIFont.boldSystemFont(ofSize: 14)
		dropzoneLabel.text = "Dropzones"
		dropzoneLabel.font = UIFont.boldSystemFont(ofSize: 14)
		exitLabel.text = "Exits"
		exitLabel.font = UIFont.boldSystemFont(ofSize: 14)
		
		skydiveCount.font = UIFont.boldSystemFont(ofSize: 30)
		baseCount.font = UIFont.boldSystemFont(ofSize: 30)
		dropzonesCount.font = UIFont.boldSystemFont(ofSize: 30)
		exitCount.font = UIFont.boldSystemFont(ofSize: 30)

		scrollView.addSubview(shadowViewSkydives)
		scrollView.addSubview(shadowViewBase)
		scrollView.addSubview(shadowViewDropzones)
		scrollView.addSubview(shadowViewExits)

		shadowViewSkydives.addSubview(skydiveCount)
		shadowViewBase.addSubview(baseCount)
		shadowViewDropzones.addSubview(dropzonesCount)
		shadowViewExits.addSubview(exitCount)

		shadowViewSkydives.addSubview(skydiveLabel)
		shadowViewBase.addSubview(baseLabel)
		shadowViewDropzones.addSubview(dropzoneLabel)
		shadowViewExits.addSubview(exitLabel)
		
		pullheight.noDataText = "No jumps to chart"
		shadowViewSkydiveStats.addSubview(skydiveFreefallTime)
		shadowViewBaseStats.addSubview(baseFreefallTime)

		pullheight.xAxis.drawLabelsEnabled = false
		pullheight.rightAxis.drawLabelsEnabled = false
		pullheight.xAxis.drawGridLinesEnabled = false
		
		exitTypes.usePercentValuesEnabled = false
		exitTypes.chartDescription?.enabled = false
		exitTypes.centerText = "Objects"
		exitTypes.drawHoleEnabled = true
		exitTypes.drawCenterTextEnabled = true
		exitTypes.noDataText = "No exits to chart"
		
		favouriteExits.noDataText = "No jumped exits to chart"
		
		shadowViewSkydiveStats.addSubview(pullheight)
		shadowViewBaseStats.addSubview(exitTypes)
		shadowViewBaseStats.addSubview(favouriteExits)
		
		scrollView.sendSubview(toBack: shadowViewSkydiveStats)
		scrollView.addSubview(shadowViewSkydiveStats)
		
		scrollView.sendSubview(toBack: shadowViewBaseStats)
		scrollView.addSubview(shadowViewBaseStats)
		/*
		if (FBSDKAccessToken.current() != nil) {
			// User is already logged in, do work such as go to next view controller.
		} else {
			scrollView.addSubview(loginView)
		}
		
		premiumButton.setTitle("GO PREMIUM", for: .normal)
		premiumButton.backgroundColor = UIColor.init(cgColor: (loginView.backgroundColor?.cgColor)!)
	
		scrollView.addSubview(premiumButton)
		*/
		
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
			
			var shadowSizes = CGSize(width: 75, height: 60)
			
			shadowViewSkydives.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 20)
			shadowViewSkydives.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)

			skydiveCount.autoCenterInSuperviewMargins()
			skydiveLabel.autoPinEdge(.top, to: .bottom, of: skydiveCount, withOffset: -5)
			skydiveLabel.autoPinEdge(.left, to: .left, of: shadowViewSkydives, withOffset: 6)
			shadowViewSkydives.autoSetDimensions(to: shadowSizes)

			baseCount.autoCenterInSuperviewMargins()
			baseLabel.autoPinEdge(.top, to: .bottom, of: baseCount, withOffset: -5)
			baseLabel.autoPinEdge(.left, to: .left, of: shadowViewBase, withOffset: 10)
			shadowViewBase.autoSetDimensions(to: shadowSizes)
			shadowViewBase.autoPinEdge(.left, to: .right, of: shadowViewSkydives, withOffset: 15)
			shadowViewBase.autoPinEdge(.top, to: .top, of: shadowViewSkydives)
			
			dropzonesCount.autoCenterInSuperviewMargins()
			dropzoneLabel.autoPinEdge(.top, to: .bottom, of: dropzonesCount, withOffset: -5)
			dropzoneLabel.autoPinEdge(.left, to: .left, of: shadowViewDropzones, withOffset: 2)
			shadowViewDropzones.autoSetDimensions(to: shadowSizes)
			shadowViewDropzones.autoPinEdge(.left, to: .right, of: shadowViewBase, withOffset: 15)
			shadowViewDropzones.autoPinEdge(.top, to: .top, of: shadowViewSkydives)
			
			exitCount.autoCenterInSuperviewMargins()
			exitLabel.autoPinEdge(.top, to: .bottom, of: exitCount, withOffset: -5)
			exitLabel.autoPinEdge(.left, to: .left, of: shadowViewExits, withOffset: 20)
			shadowViewExits.autoSetDimensions(to: shadowSizes)
			shadowViewExits.autoPinEdge(.left, to: .right, of: shadowViewDropzones, withOffset: 15)
			shadowViewExits.autoPinEdge(.top, to: .top, of: shadowViewSkydives)
			/*
			premiumButton.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)
			premiumButton.autoPinEdge(.left, to: .left, of: scrollView, withOffset: 30)
			premiumButton.autoSetDimensions(to: CGSize(width: 150, height: 30))

			
			loginView.autoPinEdge(.left, to: .right, of: premiumButton, withOffset: 40)
			loginView.autoPinEdge(.top, to: .top, of: premiumButton)
			*/

			skydiveFreefallTime.autoPinEdge(.top, to: .bottom, of: shadowViewSkydives, withOffset: 20)
			skydiveFreefallTime.autoPinEdge(.left, to: .left, of: shadowViewSkydives, withOffset: 30)
			
			pullheight.autoPinEdge(.top, to: .bottom, of: skydiveFreefallTime, withOffset: 20)
			pullheight.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 200))
			
			shadowViewSkydiveStats.autoPinEdge(.top, to: .bottom, of: shadowViewBase, withOffset: 10)
			shadowViewSkydiveStats.autoPinEdge(.bottom, to: .bottom, of: pullheight, withOffset: 20)
			shadowViewSkydiveStats.autoPinEdge(.left, to: .left, of: pullheight)
			shadowViewSkydiveStats.autoPinEdge(.right, to: .right, of: pullheight)

			baseFreefallTime.autoPinEdge(.top, to: .bottom, of: shadowViewSkydiveStats, withOffset: 20)
			baseFreefallTime.autoPinEdge(.left, to: .left, of: shadowViewSkydives, withOffset: 40)
			
			exitTypes.autoPinEdge(.top, to: .bottom, of: baseFreefallTime)
			exitTypes.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width / 2, height: 200))
			
			favouriteExits.autoPinEdge(.top, to: .bottom, of: baseFreefallTime)
			favouriteExits.autoPinEdge(.left, to: .right, of: exitTypes)
			exitTypes.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width / 2, height: 200))
			
			shadowViewBaseStats.autoPinEdge(.top, to: .bottom, of: shadowViewSkydiveStats, withOffset: 10)
			shadowViewBaseStats.autoPinEdge(.bottom, to: .bottom, of: exitTypes, withOffset: 20)
			shadowViewBaseStats.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)

			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
	
}
