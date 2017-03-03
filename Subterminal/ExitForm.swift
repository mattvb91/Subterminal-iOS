//
//  ExitForm.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 02/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import SwiftSpinner

class ExitForm: Form, CLLocationManagerDelegate {
	
	public static let NOTIFICATION_NAME = "exit_data_changed"
	
	var locationManager: CLLocationManager?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.formView = ExitFormView.newAutoLayout()
		
		let gpsTap = UITapGestureRecognizer(target: self, action: #selector(gpsAction))
		self.getFormView().coordinatesButton.addGestureRecognizer(gpsTap)

		self.view.addSubview(getFormView())
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		SwiftSpinner.hide()
		debugPrint(error)
		
		locationManager?.stopUpdatingLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		SwiftSpinner.hide()
		
		let currentLocation = locations[0]
		
		getFormView().latitude.text = currentLocation.coordinate.latitude.description
		getFormView().longtitude.text = currentLocation.coordinate.longitude.description
	}
	
	override func formIsValid() -> Bool {
		return true
	}
	
	override func assignFormToEntity() {
		
	}
	
	override func getItem() -> Exit {
		return (super.getItem() as? Exit)!
	}
	
	override func getFormView() -> ExitFormView {
		return (super.getFormView() as? ExitFormView)!
	}
	
	override func getNotificationName() -> String {
		return ExitForm.NOTIFICATION_NAME
	}
	
	
	func gpsAction(sender:UITapGestureRecognizer) {
		
		locationManager = CLLocationManager()
		locationManager?.delegate = self
		locationManager?.startUpdatingLocation()
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest
		locationManager?.requestAlwaysAuthorization()
		
		debugPrint("HERE")
		SwiftSpinner.show("Locating you...")
	}
}
