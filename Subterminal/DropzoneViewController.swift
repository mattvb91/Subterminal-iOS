//
//  DropzoneViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 12/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import MapKit

class DropzoneViewController: UIViewController {

	var item: Dropzone!
	let dropzoneView = DropzoneView.newAutoLayout()

	deinit {
		Subterminal.getMap().delegate = nil
		Subterminal.clearMap()
		
		dropzoneView.images.setImageInputs([])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		NotificationCenter.default.addObserver(self, selector: #selector(self.updateImages), name: NSNotification.Name(rawValue: "dropzoneImages"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.updateServices), name: NSNotification.Name(rawValue: "dropzoneServices"), object: nil)
					
		API.instance.getDropzoneImages(dropzone: item)
		API.instance.getDropzoneServices(dropzone: item)
			
		dropzoneView.dropzoneDescription.text = item.dropzone_description
		dropzoneView.dropzoneDescription.sizeToFit()
		dropzoneView.website.text = item.website
		dropzoneView.phone.text = item.phone
		dropzoneView.email.text = item.email
			
		dropzoneView.aircraft.text = item.getFormattedAircrafts()
			
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageFullSize))
		dropzoneView.images.addGestureRecognizer(gestureRecognizer)
		
		let location = CLLocationCoordinate2DMake(item.latitude, item.longtitude)
		let pin = MKPointAnnotation()
		pin.coordinate = location
		pin.title = item.name
			
		dropzoneView.map.mapType = MKMapType.satellite
		dropzoneView.map.addAnnotation(pin)
		dropzoneView.map.centerCoordinate = location
		let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
		let region = MKCoordinateRegion(center: pin.coordinate, span: span)
		dropzoneView.map.setRegion(region, animated: true)
			
		navigationItem.title = item.name
			
		self.view.addSubview(dropzoneView)
    }
	
	func imageFullSize() {
		dropzoneView.images.presentFullScreenController(from: self)
	}
	
	func updateImages() {
		dropzoneView.didSetupConstraints = false
		
		if((item.images?.count)! > 0) {
			dropzoneView.scrollView.addSubview(dropzoneView.images)
			dropzoneView.images.setImageInputs((item?.images)!)
		}
		
		dropzoneView.setNeedsUpdateConstraints()
	}
	
	func updateServices() {
		if((item.services?.count)! > 0) {
			dropzoneView.tagview_data = (item?.services)!
			dropzoneView.tagview.reloadData()
			
			dropzoneView.setNeedsUpdateConstraints()
			dropzoneView.updateConstraints()
		}
	}	
}
