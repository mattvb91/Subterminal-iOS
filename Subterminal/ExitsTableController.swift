//
//  ExitsTableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 27/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import SharkORM

class ExitsTableController: TableController {
	
	var publicExits: SRKResultSet = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.rowHeight = 80
	}

	
	//We have the rigs and suits on this tableview
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return items.count
		}
		
		return publicExits.count
	}
	
	//Fetch public exits seperately
	override func loadData(notification: NSNotification?) {
		self.publicExits = Exit.query().where(withFormat: "global_id IS NOT NULL", withParameters: []).fetch()
		
		return super.loadData(notification: nil)
	}
	
	//Fetch user exits
	override func fetchQuery() -> SRKQuery {
		return type(of: getAssignedModel()).query().where(withFormat: "global_id IS NULL", withParameters: [])
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "My Exits"
		case 1:
			return "Public Exits"
		default:
			return ""
		}
	}
	
	override func getAssignedModel() -> Exit {
		return Exit()
	}
	
	override func getViewCellClass() -> ExitTableViewCell {
		return ExitTableViewCell()
	}
	
	override func getViewCellIdentifier() -> String {
		return "exitTableViewCell"
	}
	
	override func assignModelToController(controller: UIViewController) {
		let controller = controller as! ExitForm
		controller.item = self.getAssignedModel()
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var model: Model?
		var cell: UITableViewCell!
		
		cell = tableView.dequeueReusableCell(withIdentifier: self.getViewCellIdentifier(), for: indexPath)

		if indexPath.section == 0 {
			model = items.object(at: indexPath.row) as! Model
		}else {
			model = publicExits.object(at: indexPath.row) as! Model
		}
		
		self.configureViewCell(cell: cell, item: model!)
		
		return cell
	}
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let controller = ExitViewController()
		
		if indexPath.section == 0 {
			controller.item = items.object(at: indexPath.row) as? Exit
		} else {
			controller.item = publicExits.object(at: indexPath.row) as? Exit
		}
		
		self.navigationController?.pushViewController(controller, animated: true)
	}
	
	override func configureViewCell(cell: UITableViewCell, item: Model) {
		let exit = item as? Exit
		let cell = cell as? ExitTableViewCell
		
		cell?.name.text = exit?.name
		
		if exit?.rockdrop_distance != nil {
			cell?.height.text = "Rockdrop: " + Subterminal.convertToDefaultUnit(distance: exit?.rockdrop_distance as! Double, fromUnit: exit!.height_unit as! Int)
			cell?.time.text = "Rockdrop Time: " + (exit?.getFormattedRockdropTime())!
		}
	
		cell?.objectType.text = exit?.getFormattedType()
	}
	
	override func getAssignedController() -> ExitForm {
		return ExitForm()
	}
}
