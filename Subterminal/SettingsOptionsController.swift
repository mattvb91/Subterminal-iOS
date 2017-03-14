//
//  SettingsOptionsController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 13/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import Bohr

class SettingsOptionsController: BOTableViewController {
	
	var options: [Int: String]!
	var settingKey: String!
	
	public init(options: [Int: String], title: String, key: String) {
		self.options = options
		self.settingKey = key

		super.init(style: UITableViewStyle.plain)
		self.navigationItem.title = title
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func setup() {
		let section = BOTableViewSection(headerTitle: nil, handler: nil)
		
		for option in options {
			section?.addCell(BOTableViewCell(title: String(describing: option.value), key: String(describing: option.key), handler: nil))
		}
		
		self.addSection(section)
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! BOTableViewCell
		
		UserDefaults.standard.setValue(indexPath.row, forKey: self.settingKey)
		
		self.navigationController?.popViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}
}
