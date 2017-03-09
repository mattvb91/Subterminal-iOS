//
//  DashboardController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
//import FBSDKLoginKit
import Charts
import SharkORM

class DashboardController: UIViewController/*, FBSDKLoginButtonDelegate*/ {

	let dashboardView = DashboardView.newAutoLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.lightGray
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Skydive.getNotificationName()), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Jump.getNotificationName()), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Exit.getNotificationName()), object: nil)

		/*
		dashboardView.loginView.readPermissions = ["public_profile", "email", "user_friends"]
		dashboardView.loginView.delegate = self
		
		dashboardView.premiumButton.addTarget(self, action: #selector(self.premium(_:)), for: .touchUpInside)
		*/
		
		dashboardView.skydiveCount.text = Skydive.query().count().description
		dashboardView.baseCount.text = Jump.query().count().description
		dashboardView.dropzonesCount.text = Skydive.query().group(by:"dropzone_id").count.description
		dashboardView.exitCount.text = Exit.query().where("global_id IS NULL").count().description

		self.setPullheightData()
		self.setExitsData()
		
		var (h, m, s) = Subterminal.secondsToHoursMinutesSeconds(seconds: Int(Skydive.query().sum(of: "delay")))
		dashboardView.skydiveFreefallTime.text = "Skydive total freefall: \(h)h \(m)m \(s)s"
		
		(h, m, s) = Subterminal.secondsToHoursMinutesSeconds(seconds: Int(Jump.query().sum(of: "delay")))
		dashboardView.baseFreefallTime.text = "B.A.S.E. total freefall: \(h)h \(m)m \(s)s"
		
		let segment: UISegmentedControl = UISegmentedControl(items: ["Skydive", "B.A.S.E."])
		segment.selectedSegmentIndex = Subterminal.mode
		segment.sizeToFit()
		segment.tintColor = self.view.tintColor
		segment.addTarget(self, action: #selector(changeMode), for: .valueChanged)

		self.navigationItem.titleView = segment
		self.view.addSubview(dashboardView)
    }
	
	/*
	@objc func premium(_ sender: AnyObject?) {
		self.navigationController?.pushViewController(PremiumController(), animated: true)
	}*/
	
	@objc func changeMode(segment: UISegmentedControl) {
		Subterminal.changeMode(mode: (segment.selectedSegmentIndex))
	}
	
	func setExitsData() {
		var vals = [PieChartDataEntry]()
		
		let buildings = Exit.query().where(withFormat: "object_type = %@", withParameters: [Exit.TYPE_BUILDING]).count()
		let antenna = Exit.query().where(withFormat: "object_type = %@", withParameters: [Exit.TYPE_ANTENNA]).count()
		let span = Exit.query().where(withFormat: "object_type = %@", withParameters: [Exit.TYPE_SPAN]).count()
		let earth = Exit.query().where(withFormat: "object_type = %@", withParameters: [Exit.TYPE_EARTH]).count()
		let other = Exit.query().where(withFormat: "object_type = %@", withParameters: [Exit.TYPE_OTHER]).count()
		
		if buildings > 0 {
			vals.append(PieChartDataEntry(value: Double(buildings), label: "Buildings"))
		}
		if antenna > 0 {
			vals.append(PieChartDataEntry(value: Double(antenna), label: "Antennas"))
		}
		if span > 0 {
			vals.append(PieChartDataEntry(value: Double(span), label: "Span"))
		}
		if earth > 0 {
			vals.append(PieChartDataEntry(value: Double(earth), label: "Earth"))
		}
		if other > 0 {
			vals.append(PieChartDataEntry(value: Double(other), label: "Other"))
		}
		
		if vals.isEmpty == false {
			let dataSet = PieChartDataSet(values: vals, label: "")
			dataSet.colors = ChartColorTemplates.material()
		
			let pieData = PieChartData(dataSet: dataSet)
		
			self.dashboardView.exitTypes.data = pieData
			self.dashboardView.exitTypes.notifyDataSetChanged()
		}
	}
	
	func setPullheightData() {
		
		let skydives = Skydive.query().order(byDescending: "date").limit(10).fetch()
		
		var yVals = [ChartDataEntry]()
		
		var i = 0
		for skydive in (skydives?.reversed())! {
			if (skydive as! Skydive).deploy_altidude != nil {
				yVals.append(ChartDataEntry(x: Double(i), y: Double((skydive as! Skydive).deploy_altidude!)))
				i += 1
			}
		}
		
		if yVals.isEmpty == false {
			let set1 = LineChartDataSet(values: yVals, label: "Pull height (Last 10 skydives)")
		
			let data = LineChartData(dataSet: set1)
			data.setValueTextColor(UIColor.white)
	
			set1.colors = [self.view.tintColor]
		
			self.dashboardView.pullheight.data = data
			self.dashboardView.pullheight.notifyDataSetChanged()
		}
		
	}
	
	/*
	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
		debugPrint("User Logged In")
		
		if ((error) != nil)
		{
			// Process error
		}
		else if result.isCancelled {
			// Handle cancellations
			debugPrint("Cancelled")
		}
		else {
			// If you ask for multiple permissions at once, you
			// should check if specific permissions missing
			if result.grantedPermissions.contains("email")
			{
				// Do work
				Subterminal.user.setFacebookUserData()
			}
		}
	}
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
		debugPrint("User Logged Out")
	}*/
}
