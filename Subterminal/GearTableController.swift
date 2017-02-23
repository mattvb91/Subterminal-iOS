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
	
	var suits: SRKResultSet = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.rowHeight = 60
    }
	
	//We have the rigs and suits on this tableview
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return items.count
		}
		
		return suits.count
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Rigs"
		case 1:
			return "Suits"
		default:
			return ""
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		tableView.register(type(of: SuitTableViewCell()), forCellReuseIdentifier: "suitCell")
		super.viewWillAppear(animated)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var model: Model?
		var cell: UITableViewCell!
		
		if indexPath.section == 0 {
			cell = tableView.dequeueReusableCell(withIdentifier: self.getViewCellIdentifier(), for: indexPath)
			model = items.object(at: indexPath.row) as! Model
		}else {
			cell = tableView.dequeueReusableCell(withIdentifier: "suitCell", for: indexPath)
			model = suits.object(at: indexPath.row) as! Model
		}
		
		self.configureViewCell(cell: cell, item: model!)
		
		return cell
	}
	
	override func loadData(notification: NSNotification?) {
		self.suits = Suit.query().fetch()
		
		return super.loadData(notification: nil)
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
	
	override func getViewCellClass() -> RigTableViewCell {
		return RigTableViewCell()
	}
	
	override func assignModelToController(controller: UIViewController) {
		let controller = controller as? GearForm
		controller?.item = getAssignedModel()
	}
	
	//Configure suit or rig viewcell
	override func configureViewCell(cell: UITableViewCell, item: Model) {
		
		if item.isKind(of: Rig.self) {
			let rig = item as? Rig
			let cell = cell as? RigTableViewCell
		
			cell?.containerModelLabel.text = rig?.container_model
			cell?.containerManufacturerLabel.text = rig?.container_manufacturer
		} else {
			let suit = item as? Suit
			let cell = cell as? SuitTableViewCell
			
			cell?.type.text = suit?.getFormattedType()
			cell?.modelLabel.text = suit?.model
			cell?.manufacturerLabel.text = suit?.manufacturer
		}
    }
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		if indexPath.section == 0 {
			let rigForm = GearForm()
			rigForm.item = items.object(at: indexPath.row) as? Rig
		
			self.navigationController?.pushViewController(rigForm, animated: true)
		}
	}
	
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
		
			var item: Model!
			
			if indexPath.section == 0 {
				item = items.object(at: indexPath.row) as? Model
			} else {
				item = suits.object(at: indexPath.row) as? Model
			}
			item?.remove()
			
			items = type(of: getAssignedModel()).query().fetch()
			suits = Suit.query().fetch()
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
}
