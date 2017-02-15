//
//  GearTableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import SharkORM
import os.log
import NotificationCenter

class GearTableController: TableController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.rowHeight = 60
    }
	
	override func getNotificationName() -> String {
		return GearForm.NOTIFICATION_NAME
	}
	
	override func getViewCellIdentifier() -> String {
		return "rigTableViewCell"
	}
	
	override func getAssignedModel() -> Rig {
		return Rig()
	}
	
	override func getAssignedController() -> UIViewController {
		return GearForm()
	}
	
	override func assignModelToController(controller: UIViewController) {
		let controller = controller as? GearForm
		controller?.item = getAssignedModel()
	}
	
	override func configureViewCell(cell: UITableViewCell, item: Model) {
		let rig = item as? Rig
		let cell = cell as? RigTableViewCell
		
		cell?.containerModelLabel.text = rig?.container_model
		cell?.containerManufacturerLabel.text = rig?.container_manufacturer
    }
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let rigForm = GearForm()
		rigForm.item = items.object(at: indexPath.row) as? Rig
		
		self.navigationController?.pushViewController(rigForm, animated: true)
	}
}
