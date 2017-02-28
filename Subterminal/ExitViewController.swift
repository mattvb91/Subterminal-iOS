//
//  ExitViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ExitViewController: UIViewController {
	
	var item: Exit!
	let exitView = ExitView.newAutoLayout()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = item.name
		
		exitView.exitInfo.text = item.exit_description
		exitView.exitInfo.sizeToFit()
		
		exitView.rockdrop.text = item.rockdrop_distance?.description
		exitView.rockdropTime.text = "s"
		exitView.altitudeToLanding.text = item.altitude_to_landing?.description
		
		let location = CLLocationCoordinate2DMake(item.latitude, item.longtitude)
		
		let pin = MKPointAnnotation()
		pin.coordinate = location
		pin.title = item.name
		
		exitView.map.mapType = MKMapType.satellite
		exitView.map.addAnnotation(pin)
		exitView.map.centerCoordinate = location
		let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
		let region = MKCoordinateRegion(center: pin.coordinate, span: span)
		exitView.map.setRegion(region, animated: true)

		self.view.addSubview(exitView)
	}
}

