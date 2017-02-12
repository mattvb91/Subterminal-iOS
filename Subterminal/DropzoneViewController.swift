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
	
	@IBOutlet weak var dropzoneDescription: UITextView!
	@IBOutlet weak var website: UILabel!
	@IBOutlet weak var phone: UILabel!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var map: MKMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if let item = item {
			dropzoneDescription.text = item.dropzone_description
			dropzoneDescription.sizeToFit()
			website.text = item.website
			phone.text = item.phone
			email.text = item.email
			
			let location = CLLocationCoordinate2DMake(item.latitude, item.longtitude)
		
			let pin = MKPointAnnotation()
			pin.coordinate = location
			pin.title = item.name
			
			map.mapType = MKMapType.satellite
			map.addAnnotation(pin)
			map.centerCoordinate = location
			let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
			let region = MKCoordinateRegion(center: pin.coordinate, span: span)
			map.setRegion(region, animated: true)
			
			navigationItem.title = item.name
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
