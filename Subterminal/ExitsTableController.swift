//
//  ExitsTableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 27/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit

class ExitsTableController: TableController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.rowHeight = 80
	}

	
	//We have the rigs and suits on this tableview
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 1 {
			return items.count
		}
		
		return items.count
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
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let exitController = ExitViewController()
		exitController.item = items.object(at: indexPath.row) as? Exit
		
		self.navigationController?.pushViewController(exitController, animated: true)
	}
	
	override func getNotificationName() -> String {
		return "exit_notification"
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
	
	override func configureViewCell(cell: UITableViewCell, item: Model) {
		let exit = item as? Exit
		let cell = cell as? ExitTableViewCell
		
		cell?.name.text = exit?.name
		cell?.height.text = exit?.rockdrop_distance?.description
		cell?.objectType.text = exit?.getFormattedType()
	}
	
	override func getAssignedController() -> ExitForm {
		return ExitForm()
	}
}
