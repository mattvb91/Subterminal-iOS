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
	
	static let DEFAULT_SKYDIVE_TYPE = "defaultSkydiveType"
	static let DEFAULT_SKYDIVE_COUNT = "startSkydiveCount"
	static let DEFAULT_SKYDIVE_AIRCRAFT = "defaultAircraft"
	
	static let DEFAULT_BASE_TYPE = "setting_base_type"
	static let DEFAULT_BASE_COUNT = "setting_base_start_count"
	static let DEFAULT_BASE_PC = "setting_pc_size"
	static let DEFAULT_BASE_SLIDER = "setting_base_slider"
	
	static let DEFAULT_HEIGHT_UNIT = "settings_height_unit"

	override func setup() {
		
		self.title = "Settings"
		
		let section = BOTableViewSection()
		section.headerTitle = "General"
		
		let websiteCell = BOButtonTableViewCell(title: "Visit Website", key: nil, handler: nil)
		websiteCell?.placeholderText = "https://subterminal.eu"
		websiteCell?.actionBlock = {
			UIApplication.shared.open(NSURL(string:"https://subterminal.eu") as! URL, options: [:], completionHandler: nil)
		}
		
		let heightUnitCell = BOChoiceTableViewCell(title: "Height Unit:", key: SettingsController.DEFAULT_HEIGHT_UNIT, handler: nil)
		heightUnitCell?.options = ["Metric (m)", "Imperial (ft)"]
	
		section.addCell(heightUnitCell)
		section.addCell(websiteCell)
		self.addSection(section)
		
		let sectionSkydiving = BOTableViewSection(headerTitle: "Skydiving", handler: nil)
		
		let skydiveStartNo = BONumberTableViewCell(title: "Start jump #", key: SettingsController.DEFAULT_SKYDIVE_COUNT, handler: nil)
		skydiveStartNo?.textField.placeholder = "0"
		
		sectionSkydiving?.addCell(skydiveStartNo)
		
		let defaultAircraft = BOChoiceTableViewCell(title: "Default Aircraft", key: SettingsController.DEFAULT_SKYDIVE_AIRCRAFT, handler: nil)
		let aircraftController = SettingsOptionsController(options: Aircraft.getAircrafts(), title: "Default Aircraft", key: (defaultAircraft?.key)!)
		defaultAircraft?.destinationViewController = aircraftController
		defaultAircraft?.options = Aircraft.getForSelect()
	
		sectionSkydiving?.addCell(defaultAircraft)
		
		let defaultJumpType = BOChoiceTableViewCell(title: "Default Type", key: SettingsController.DEFAULT_SKYDIVE_TYPE, handler: nil)
		let jumpTypeController = SettingsOptionsController(options: Skydive.types, title: "Default Type", key: (defaultJumpType?.key)!)
		defaultJumpType?.destinationViewController = jumpTypeController
		defaultJumpType?.options = Skydive.getTypesForSelect()
		sectionSkydiving?.addCell(defaultJumpType)
		
		self.addSection(sectionSkydiving)

		let sectionBASE = BOTableViewSection(headerTitle: "B.A.S.E.", handler: nil)
		self.addSection(sectionBASE)
		
		let baseStartNo = BONumberTableViewCell(title: "Start jump #", key: SettingsController.DEFAULT_BASE_COUNT, handler: nil)
		baseStartNo?.textField.placeholder = "0"
		
		let defaultBaseType = BOChoiceTableViewCell(title: "Default Type", key: SettingsController.DEFAULT_BASE_TYPE, handler: nil)
		let baseTypeController = SettingsOptionsController(options: Jump.jump_type, title: "Default Type", key: (defaultBaseType?.key)!)
		defaultBaseType?.destinationViewController = baseTypeController
		defaultBaseType?.options = Jump.getTypesForSelect()
		
		let defaultPC = BOChoiceTableViewCell(title: "Default PC", key: SettingsController.DEFAULT_BASE_PC, handler: nil)
		defaultPC?.options = Jump.pc_sizes
		
		let defaultSlider = BOChoiceTableViewCell(title: "Default Slider", key: SettingsController.DEFAULT_BASE_SLIDER, handler: nil)
		defaultSlider?.options = Jump.getSliderConfigForDropdown()
	
		sectionBASE?.addCell(baseStartNo)
		sectionBASE?.addCell(defaultBaseType)
		sectionBASE?.addCell(defaultPC)
		sectionBASE?.addCell(defaultSlider)
	}
}
