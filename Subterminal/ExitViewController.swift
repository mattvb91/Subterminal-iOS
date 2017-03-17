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
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Exit.getNotificationName()), object: nil)

		if !item.isGlobal() {
			let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))
			self.navigationItem.rightBarButtonItem = editButton
		}
		
		if item.isGlobal() == false {
			exitView.detailView.removeFromSuperview()
			exitView.exitRulesLabel.removeFromSuperview()
			exitView.exitRules.removeFromSuperview()
		} else {
			//Assign difficulty values
			exitView.exitRules.text = item.getDetails()?.rules
			exitView.exitRules.sizeToFit()
			
			exitView.difficultyTrackingExitValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_tracking_exit)!))
			exitView.difficultyTrackingFreefallValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_tracking_freefall)!))
			exitView.difficultyTrackingLandingValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_tracking_landing)!))
			exitView.difficultyTrackingOverallValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_tracking_overall)!))
			
			exitView.difficultyTrackingExitValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_tracking_exit)!))
			exitView.difficultyTrackingFreefallValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_tracking_freefall)!))
			exitView.difficultyTrackingLandingValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_tracking_landing)!))
			exitView.difficultyTrackingOverallValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_tracking_overall)!))
			
			exitView.difficultyWingsuitExitValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_wingsuit_exit)!))
			exitView.difficultyWingsuitFreefallValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_wingsuit_freefall)!))
			exitView.difficultyWingsuitLandingValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_wingsuit_landing)!))
			exitView.difficultyWingsuitOverallValue.text = ExitDetails.getFormattedDifficulty(difficulty: Int((item.getDetails()?.difficulty_wingsuit_overall)!))
			
			exitView.difficultyWingsuitExitValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_wingsuit_exit)!))
			exitView.difficultyWingsuitFreefallValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_wingsuit_freefall)!))
			exitView.difficultyWingsuitLandingValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_wingsuit_landing)!))
			exitView.difficultyWingsuitOverallValue.textColor = ExitDetails.getDifficultyColor(difficulty: Int((item.getDetails()?.difficulty_wingsuit_overall)!))
		}
		
		exitView.exitInfo.text = item.exit_description
		exitView.exitInfo.sizeToFit()
		
		if item.rockdrop_distance != nil {
			exitView.rockdrop.text = Subterminal.convertToDefaultUnit(distance: Double(item.rockdrop_distance!), fromUnit: Int(item.height_unit))
			exitView.rockdropTime.text = item.getFormattedRockdropTime()
		}
		
		if item.altitude_to_landing != nil {
			exitView.altitudeToLanding.text = Subterminal.convertToDefaultUnit(distance: Double(item.altitude_to_landing!), fromUnit: Int(item.height_unit))
		}
		
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
	
	func editAction() {
		let formController = ExitForm()
		formController.item = self.item
		
		self.navigationController?.pushViewController(formController, animated: true)
	}
}

