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
	
	var locationManager: CLLocationManager?
	
	override func viewDidLoad() {
		self.formView = ExitFormView.newAutoLayout()
		super.viewDidLoad()
		
		self.navigationItem.title = "Edit Exit"
		
		let gpsTap = UITapGestureRecognizer(target: self, action: #selector(gpsAction))
		self.getFormView().coordinatesButton.addGestureRecognizer(gpsTap)

		if self.getItem().id != nil {
			getFormView().name.text = self.getItem().name
			getFormView().rockdrop.text = self.getItem().rockdrop_distance?.description
			getFormView().altitudeToLanding.text = self.getItem().altitude_to_landing?.description
			getFormView().exitDescription.text = self.getItem().exit_description
			getFormView().latitude.text = self.getItem().latitude.description
			getFormView().longtitude.text = self.getItem().longtitude.description
			getFormView().typeDropdown.selectRowForDataSourceWithKey(key: Int(self.getItem().object_type!), data: Exit.types, label: getFormView().type)
			getFormView().heightUnit.selectedSegmentIndex = Int(getItem().height_unit)
		} else {
			getFormView().typeDropdown.selectRowForDataSourceWithKey(key: Exit.TYPE_BUILDING, data: Exit.types, label: getFormView().type)
			getFormView().heightUnit.selectedSegmentIndex = UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_HEIGHT_UNIT)
		}
		
		self.view.addSubview(getFormView())
	}
	
	override func initFormValidation() {
		self.validator.addRequiredField(field: self.getFormView().name)
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
	
	override func assignFormToEntity() {
		self.getItem().name = self.getFormView().name.text
		self.getItem().height_unit = (self.getFormView().heightUnit.selectedSegmentIndex as NSNumber?)!
		
		if self.getFormView().rockdrop.text?.isEmpty == false {
			self.getItem().rockdrop_distance = NSNumber(value: Int(self.getFormView().rockdrop.text!)!)
		}
		
		if self.getFormView().altitudeToLanding.text?.isEmpty == false {
			self.getItem().altitude_to_landing = NSNumber(value: Int(self.getFormView().altitudeToLanding.text!)!)
		}
		
		self.getItem().exit_description = self.getFormView().exitDescription.text
		
		if self.getFormView().latitude.text?.isEmpty == false {
			self.getItem().latitude = Double(self.getFormView().latitude.text!)!
		}
		
		if self.getFormView().longtitude.text?.isEmpty == false {
			self.getItem().longtitude = Double(self.getFormView().longtitude.text!)!
		}
		
		self.getItem().height_unit = getFormView().heightUnit.selectedSegmentIndex as NSNumber!
		
		self.getItem().object_type = NSNumber(value: getFormView().typeDropdown.getKeyForDataFromSelectedRow(data: Exit.types)!)
	}
	
	override func getItem() -> Exit {
		return (super.getItem() as? Exit)!
	}
	
	override func getFormView() -> ExitFormView {
		return (super.getFormView() as? ExitFormView)!
	}	
	
	func gpsAction(sender:UITapGestureRecognizer) {
		locationManager = CLLocationManager()
		locationManager?.delegate = self
		locationManager?.startUpdatingLocation()
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest
		locationManager?.requestAlwaysAuthorization()
		
		SwiftSpinner.show("Locating you...")
	}
}
