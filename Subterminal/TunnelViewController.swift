//
//  TunnelViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 05/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class TunnelViewController: UIViewController {
	var item: Tunnel!
	var tunnelView = TunnelView.newAutoLayout()
	
	deinit {
		Subterminal.getMap().delegate = nil
		Subterminal.clearMap()
		
		tunnelView.images.setImageInputs([])
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.updateImages), name: NSNotification.Name(rawValue: "tunnelImages"), object: nil)

		API.instance.getTunnelImages(tunnel: item)
		tunnelView.tunnelDescription.text = item.tunnel_description
		tunnelView.tunnelDescription.sizeToFit()
		tunnelView.website.text = item.website
		tunnelView.phone.text = item.phone
		tunnelView.email.text = item.email
		
		let location = CLLocationCoordinate2DMake(item.latitude, item.longtitude)
		let pin = MKPointAnnotation()
		pin.coordinate = location
		pin.title = item.name
		
		tunnelView.map.mapType = MKMapType.satellite
		tunnelView.map.addAnnotation(pin)
		tunnelView.map.centerCoordinate = location
		let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
		let region = MKCoordinateRegion(center: pin.coordinate, span: span)
		tunnelView.map.setRegion(region, animated: true)

		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageFullSize))
		tunnelView.images.addGestureRecognizer(gestureRecognizer)

		navigationItem.title = item.name

		self.view.addSubview(tunnelView)
	}

	func imageFullSize() {
		tunnelView.images.presentFullScreenController(from: self)
	}
	
	func updateImages() {
		tunnelView.didSetupConstraints = false
		
		if((item.images?.count)! > 0) {
			tunnelView.scrollView.addSubview(tunnelView.images)
			tunnelView.images.setImageInputs((item?.images)!)
		}
		
		tunnelView.setNeedsUpdateConstraints()
	}

	
}
