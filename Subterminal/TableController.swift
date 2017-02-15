//
//  TableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 15/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import SharkORM

class TableController: UITableViewController {

	var items: SRKResultSet = []
	var numberOfSections = 1
	
	var canEditItems = true
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if(canEditItems) {
			NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: NSNotification.Name(rawValue: self.getNotificationName()), object: nil)
			
			let add = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
			
			self.navigationItem.rightBarButtonItem = add
		}
		
		loadData(notification: nil);
	}

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

	override func viewWillAppear(_ animated: Bool) {
		tableView.register(RigTableViewCell.self, forCellReuseIdentifier: self.getViewCellIdentifier())
		
		if self.tableView.indexPathForSelectedRow != nil {
			self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
		}
	}
	
	func loadData(notification: NSNotification?) {
		items = type(of: getAssignedModel()).query().fetch()
		
		self.tableView.reloadData()
		
		if(items.count > 0 && self.canEditItems) {
			self.navigationItem.leftBarButtonItem = self.editButtonItem
		}
	}
	
	//The user pressed the add button
	func addTapped() {
		let transition = CATransition()
		transition.duration = 0.5
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		transition.type = kCATransitionPush;
		transition.subtype = kCATransitionFromTop
		
		let controller = getAssignedController()
		self.assignModelToController(controller: controller)
	
		self.navigationController?.view.layer.add(transition, forKey: kCATransition)
		self.navigationController?.pushViewController(controller,animated: false)
	}
	
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.getViewCellIdentifier(), for: indexPath)

		self.configureViewCell(cell: cell, item: items.object(at: indexPath.row) as! Model)
		
        return cell
    }
	
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			
			// Delete the row from the data source
			let item = items.object(at: indexPath.row) as? Model
			item?.remove()
			
			items = type(of: getAssignedModel()).query().fetch()
			tableView.deleteRows(at: [indexPath], with: .fade)
			
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
	func assignModelToController(controller: UIViewController) {
		fatalError("assignModelToController() not implemented")
	}

	func getNotificationName() -> String {
		fatalError("getNotificationName() not implemented")
	}
	
	func getAssignedController() -> UIViewController {
		fatalError("getAssignedController() not implemented")
	}
	
	func getAssignedModel() -> Model {
		fatalError("getAssignedModel() not implemented")
	}
	
	func getViewCellIdentifier() -> String {
		fatalError("getViewCellIdentifier() not implemented")
	}
	
	func configureViewCell(cell: UITableViewCell, item: Model) {
		fatalError("configureViewcell(cell) not implemented")
	}

}
