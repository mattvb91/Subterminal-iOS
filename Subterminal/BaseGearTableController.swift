//
//  BaseGearTableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SharkORM
import UIKit

class BaseGearTableController: TableController {
	
	var suits: SRKResultSet = []
	
	override func viewDidLoad() {

		self.canEditItems = false
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: NSNotification.Name(rawValue: Suit.getNotificationName()), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: NSNotification.Name(rawValue: BASERig.getNotificationName()), object: nil)
		
		super.viewDidLoad()
		
		self.canEditItems = true
		
		let addRig = UIBarButtonItem(title: "Add Rig", style: .plain, target: self, action: #selector(addTapped))
		let addSuit = UIBarButtonItem(title: "Add Suit", style: .plain, target: self, action: #selector(addSuitTapped))
		
		self.navigationItem.rightBarButtonItem = addRig
		self.navigationItem.leftBarButtonItem = addSuit

		
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

	override func getViewCellIdentifier() -> String {
		return "rigTableViewCell"
	}
	
	override func getAssignedModel() -> BASERig {
		return BASERig()
	}
	
	override func getAssignedController() -> RigForm {
		return RigForm()
	}
	
	override func getViewCellClass() -> RigTableViewCell {
		return RigTableViewCell()
	}
	
	override func assignModelToController(controller: UIViewController) {
		let controller = controller as! RigForm
		controller.item = self.getAssignedModel()
	}
	
	//Configure suit or rig viewcell
	override func configureViewCell(cell: UITableViewCell, item: Model) {
		
		if item.isKind(of: BASERig.self) {
			let rig = item as? BASERig
			let cell = cell as? RigTableViewCell
			
			cell?.containerModelLabel.text = rig?.container_type
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
			let rigForm = self.getAssignedController()
			rigForm.item = items.object(at: indexPath.row) as? BASERig
			
			self.navigationController?.pushViewController(rigForm, animated: true)
		} else {
			let suitForm = SuitForm()
			suitForm.item = suits.object(at: indexPath.row) as? Suit
			
			self.navigationController?.pushViewController(suitForm, animated: true)
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
	
	//The user pressed the add button
	func addSuitTapped() {
		let transition = CATransition()
		transition.duration = 0.5
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		transition.type = kCATransitionPush;
		transition.subtype = kCATransitionFromTop
		
		let controller = SuitForm()
		controller.item = Suit()
		
		self.navigationController?.view.layer.add(transition, forKey: kCATransition)
		self.navigationController?.pushViewController(controller,animated: false)
	}
}
