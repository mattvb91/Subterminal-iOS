//
//  SettingsController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import Bohr

class SettingsController: BOTableViewController {
	
	override func setup() {
		
		self.title = "Settings"
		
		let section = BOTableViewSection()
		section.headerTitle = "General"
		
		let websiteCell = BOButtonTableViewCell(title: "Visit Website", key: nil, handler: nil)
		websiteCell?.placeholderText = "https://subterminal.eu"
		websiteCell?.actionBlock = {
			UIApplication.shared.open(NSURL(string:"https://subterminal.eu") as! URL, options: [:], completionHandler: nil)
		}
		
		let heightUnitCell = BOChoiceTableViewCell(title: "Height Unit:", key: "heightUnit", handler: nil)
		heightUnitCell?.options = ["Metric (m)", "Imperial (ft)"]
	
		section.addCell(heightUnitCell)
		section.addCell(websiteCell)
		self.addSection(section)
		
		let sectionSkydiving = BOTableViewSection(headerTitle: "Skydiving", handler: nil)
		
		let skydiveStartNo = BONumberTableViewCell(title: "Start jump #", key: "startSkydiveCount", handler: nil)
		skydiveStartNo?.textField.placeholder = "0"
		
		sectionSkydiving?.addCell(skydiveStartNo)
		
		let defaultAircraft = BOChoiceTableViewCell(title: "Default Aircraft", key: "defaultAircraft", handler: nil)
		let aircraftController = SettingsOptionsController(options: Aircraft.getAircrafts(), title: "Default Aircraft", key: (defaultAircraft?.key)!)
		defaultAircraft?.destinationViewController = aircraftController
		defaultAircraft?.options = Aircraft.getForSelect()
	
		sectionSkydiving?.addCell(defaultAircraft)
		
		let defaultJumpType = BOChoiceTableViewCell(title: "Default Type", key: "defaultSkydiveType", handler: nil)
		let jumpTypeController = SettingsOptionsController(options: Skydive.types, title: "Default Type", key: (defaultJumpType?.key)!)
		defaultJumpType?.destinationViewController = jumpTypeController
		defaultJumpType?.options = Skydive.getTypesForSelect()
		sectionSkydiving?.addCell(defaultJumpType)
		
		self.addSection(sectionSkydiving)

		let sectionBASE = BOTableViewSection(headerTitle: "B.A.S.E.", handler: nil)
		self.addSection(sectionBASE)
		
		let baseStartNo = BONumberTableViewCell(title: "Start jump #", key: "startBASECount", handler: nil)
		baseStartNo?.textField.placeholder = "0"
		
		let defaultBaseType = BOChoiceTableViewCell(title: "Default Type", key: "defaultBaseType", handler: nil)
		let baseTypeController = SettingsOptionsController(options: Jump.jump_type, title: "Default Type", key: (defaultBaseType?.key)!)
		defaultBaseType?.destinationViewController = baseTypeController
		defaultBaseType?.options = Jump.getTypesForSelect()
		
		sectionBASE?.addCell(baseStartNo)
		sectionBASE?.addCell(defaultBaseType)
	}
}
