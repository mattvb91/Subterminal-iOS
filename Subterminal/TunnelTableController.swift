//
//  TunnelTableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 05/04/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import SharkORM

class TunnelTableController: TableController {
	
	override func viewDidLoad() {
		self.canEditItems = false
		self.tableView.rowHeight = 70

		super.viewDidLoad()
	}
	
	override func fetchQuery() -> SRKQuery {
		return type(of: getAssignedModel()).query().order(by: "featured DESC, name ASC")
	}
	
	override func getViewCellClass() -> TunnelTableViewCell {
		return TunnelTableViewCell()
	}
	
	override func assignModelToController(controller: UIViewController) {
		fatalError("assignModelToController() not implemented")
	}
	
	override func getAssignedController() -> UIViewController {
		fatalError("getAssignedController() not implemented")
	}
	
	override func getAssignedModel() -> Model {
		return Tunnel()
	}
	
	override func getViewCellIdentifier() -> String {
		return "tunnelTableViewCell"
	}
	
	override func configureViewCell(cell: UITableViewCell, item: Model) {
		let tunnel = item as! Tunnel
		let cell = cell as! TunnelTableViewCell
		
		cell.backgroundColor = UIColor.white
		
		if tunnel.featured == 1 {
			cell.backgroundColor = UIColor(red:0.88, green:0.97, blue:0.85, alpha:1.0)
		}
		
		cell.name.text = tunnel.name
		cell.country.text = tunnel.country
		
	}

	
}
