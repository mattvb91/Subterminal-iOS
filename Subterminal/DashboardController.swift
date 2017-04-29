//
//  DashboardController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import Charts
import SharkORM
import SwiftyStoreKit

class DashboardController: UIViewController {

	let dashboardView = DashboardView.newAutoLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.lightGray
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Skydive.getNotificationName()), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Jump.getNotificationName()), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Exit.getNotificationName()), object: nil)
		
		let settings = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsTapped))
		self.navigationItem.leftBarButtonItem = settings
		
		if Subterminal.user.isLoggedIn() == false {
			let signIn = UIBarButtonItem(title: "Sign in", style: .plain, target: self, action: #selector(signInTapped))
			self.navigationItem.rightBarButtonItem = signIn
		} else if Subterminal.user.isPremium() == false {
			let buyPremium = UIBarButtonItem(title: "Premium", style: .plain, target: self, action: #selector(buyPremiumTapped))
			self.navigationItem.rightBarButtonItem = buyPremium
		}
		
		dashboardView.skydiveCount.text = Skydive.query().count().description
		dashboardView.baseCount.text = Jump.query().count().description
		dashboardView.dropzonesCount.text = Skydive.query().group(by:"dropzone_id").count.description
		dashboardView.exitCount.text = Exit.query().where("global_id IS NULL").count().description

		self.setPullheightData()
		self.setExitsData()
		self.setFavouriteExitsData()
		
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
	
	@objc func changeMode(segment: UISegmentedControl) {
		Subterminal.changeMode(mode: (segment.selectedSegmentIndex))
	}
	
	func settingsTapped() {
		self.navigationController?.pushViewController(SettingsController(), animated: true)
	}
	
	func signInTapped() {
		self.navigationController?.pushViewController(LoginController(), animated: true)
	}
	
	func buyPremiumTapped() {
		SwiftyStoreKit.purchaseProduct("subterminal_premium", atomically: false) { result in
			var title, message: String?
			
			switch result {
				case .success(let product):
		
					if let receiptData = SwiftyStoreKit.localReceiptData {
						let receipt = receiptData.base64EncodedString()
						API.instance.sendPurchaseReceipt(receipt: receipt)
					}
					
					// fetch content from your server, then:
					if product.needsFinishTransaction {
						SwiftyStoreKit.finishTransaction(product.transaction)
					}
					title = "Success"
					message = "Premium Confirmed!"
				
				case .error(let error):
					title = "Error"
					switch error.code {
					case .unknown: message = "Unknown error. Please contact support"
					case .clientInvalid: message = "Not allowed to make the payment"
					case .paymentCancelled: break
					case .paymentInvalid: message = "The purchase identifier was invalid"
					case .paymentNotAllowed: message = "The device is not allowed to make the payment"
					case .storeProductNotAvailable: message = "The product is not available in the current storefront"
					case .cloudServicePermissionDenied: message = "Access to cloud service information is not allowed"
					case .cloudServiceNetworkConnectionFailed: message = "Could not connect to the network"
					default: message = "Unknown error. Please contact support"
				}
			}
			
			let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}

	func setFavouriteExitsData() {
		
		self.dashboardView.favouriteExits.chartDescription?.enabled = false
		self.dashboardView.favouriteExits.xAxis.enabled = false
		self.dashboardView.favouriteExits.leftAxis.enabled = true
		self.dashboardView.favouriteExits.rightAxis.enabled = false
		
		let l = self.dashboardView.favouriteExits.legend
		l.verticalAlignment = Legend.VerticalAlignment.bottom
		l.horizontalAlignment = Legend.HorizontalAlignment.left
		l.orientation = Legend.Orientation.horizontal
		l.drawInside = false
		l.form = Legend.Form.none
		
		var yVals = [BarChartDataEntry]()
		
		let sql = SharkORM.rawQuery("SELECT exit_id, count(exit_id) as total_count FROM Jump WHERE exit_id IS NOT NULL GROUP BY exit_id ORDER BY total_count DESC LIMIT 3") as SRKRawResults
		
		var values = [String]()
		
		var i = 1
		for results in sql.rawResults {
			let results = results as! NSDictionary
			let count = results["total_count"] as! Double
			let exitId = results["exit_id"] as! NSNumber
			let exit = Exit.init(primaryKeyValue: exitId)!
			yVals.append(BarChartDataEntry(x: Double(i), y: count, data: exit.name as AnyObject?))
			i += 1
			values.append(exit.name!)
		}
		
		let set = BarChartDataSet(values: yVals, label: "Favourite Exits")
		set.colors = ChartColorTemplates.material()
		set.valueFont = UIFont.systemFont(ofSize: 12)
		
		set.valueFormatter = BarFormatter(values: values)
		
		let barData = BarChartData(dataSet: set)
		
		self.dashboardView.favouriteExits.data = barData
		self.dashboardView.favouriteExits.notifyDataSetChanged()
	}
	
	func setExitsData() {
		var vals = [PieChartDataEntry]()
		
		let buildings = Exit.query().where(withFormat: "object_type = %@ AND global_id IS NULL", withParameters: [Exit.TYPE_BUILDING]).count()
		let antenna = Exit.query().where(withFormat: "object_type = %@  AND global_id IS NULL", withParameters: [Exit.TYPE_ANTENNA]).count()
		let span = Exit.query().where(withFormat: "object_type = %@  AND global_id IS NULL", withParameters: [Exit.TYPE_SPAN]).count()
		let earth = Exit.query().where(withFormat: "object_type = %@  AND global_id IS NULL", withParameters: [Exit.TYPE_EARTH]).count()
		let other = Exit.query().where(withFormat: "object_type = %@  AND global_id IS NULL", withParameters: [Exit.TYPE_OTHER]).count()
		
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
			let formatter = NumberFormatter()
			formatter.numberStyle = .none
			formatter.maximumFractionDigits = 0
			
			let dataSet = PieChartDataSet(values: vals, label: "")
			dataSet.colors = ChartColorTemplates.material()
			
			let pieData = PieChartData(dataSet: dataSet)
			pieData.setValueFont(UIFont.systemFont(ofSize: 12))
			pieData.setValueTextColor(NSUIColor.black)
			pieData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
			
			self.dashboardView.exitTypes.data = pieData
			self.dashboardView.exitTypes.notifyDataSetChanged()
		}
	}
	
	func setPullheightData() {
		
		let skydives = Skydive.query().order(byDescending: "date").limit(10).fetch()
		
		var yVals = [ChartDataEntry]()
		
		var i = 0
		for skydive in skydives! {
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
}

class BarFormatter: NSObject, IValueFormatter {

	var stringsValues:[String] = []
	
	init(values:[String]) {
		stringsValues = values
	}
	
	public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
		return self.stringsValues[Int(entry.x - 1)]
	}
}
