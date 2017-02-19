//
//  SkydiveTableViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import os.log

class SkydiveTableViewController: TableController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = "Skydives"
		
        self.clearsSelectionOnViewWillAppear = false
		self.navigationItem.leftBarButtonItem = self.editButtonItem
		
		self.tableView.rowHeight = 80
    }

	override func getViewCellIdentifier() -> String {
		return "skydiveTableViewCell"
	}
	
	override func configureViewCell(cell: UITableViewCell, item: Model)
	{
		let cell = cell as? SkydiveTableViewCell
		let item = item as? Skydive
		
        // Configure the cell...
		cell?.dropzone.text = "Irish Parachute Club"
		cell?.aircraft.text = item?.aircraft()?.name
		cell?.delay.text = (item?.delay?.stringValue)! + "s"
    }
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let skydiveController = SkydiveViewController()
		skydiveController.item = items.object(at: indexPath.row) as? Skydive
		
		self.navigationController?.pushViewController(skydiveController, animated: true)
	}
	
	override func getNotificationName() -> String {
		return SkydiveForm.NOTIFICATION_NAME
	}
	
	override func getAssignedModel() -> Model {
		return Skydive()
	}
	
	override func getViewCellClass() -> SkydiveTableViewCell {
		return SkydiveTableViewCell()
	}
	
	override func getAssignedController() -> SkydiveForm {
		return SkydiveForm()
	}
	
	override func assignModelToController(controller: UIViewController)
	{
		let controller = controller as? SkydiveForm
		controller?.item = getAssignedModel()
	}
}
