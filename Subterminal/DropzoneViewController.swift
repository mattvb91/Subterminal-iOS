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

	var item: Dropzone?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let dropzoneView = DropzoneView.newAutoLayout()
		
		if let item = item {
			dropzoneView.dropzone = item
			
			dropzoneView.dropzoneDescription.text = item.dropzone_description
			dropzoneView.dropzoneDescription.sizeToFit()
			dropzoneView.website.text = item.website
			dropzoneView.phone.text = item.phone
			dropzoneView.email.text = item.email
			
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
	
    }
}
