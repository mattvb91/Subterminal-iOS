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

class GearTableController: UITableViewController {

	var items: SRKResultSet = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: NSNotification.Name(rawValue: GearForm.NOTIFICATION_NAME), object: nil)
		
		let add = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
		
		self.navigationItem.rightBarButtonItem = add
	
		loadData(notification: nil);
    }
	
	override func viewWillAppear(_ animated: Bool) {
		tableView.register(RigTableViewCell.self, forCellReuseIdentifier: "rigTableViewCell")
		
		if self.tableView.indexPathForSelectedRow != nil {
			self.tableView.deselectRow(at: self.tableView.indexPathForSelectedRow!, animated: true)
		}
	}
	
	func addTapped() {
		let transition = CATransition()
		transition.duration = 0.5
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		transition.type = kCATransitionPush;
		transition.subtype = kCATransitionFromTop
		
		let gearController = GearForm()
		gearController.item = Rig()
		
		self.navigationController?.view.layer.add(transition, forKey: kCATransition)
		self.navigationController?.pushViewController(gearController,animated: false)
	}
	
	func loadData(notification: NSNotification?) {
		items = Rig.query().fetch()
		self.tableView.reloadData()
		
		if(items.count > 0) {
			self.navigationItem.leftBarButtonItem = self.editButtonItem
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "rigTableViewCell", for: indexPath) as? RigTableViewCell else {
			fatalError("Could not get cell")
		}

        // Configure the cell...
		let rig = items.object(at: indexPath.row) as? Rig
		
		cell.containerModelLabel.text = rig?.container_model
		cell.containerManufacturerLabel.text = rig?.container_manufacturer
		
        return cell
    }
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let rigForm = GearForm()
		rigForm.item = items.object(at: indexPath.row) as? Rig
		
		self.navigationController?.pushViewController(rigForm, animated: true)
	}

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			
			// Delete the row from the data source
			let rig = items.object(at: indexPath.row) as? Rig
			rig?.remove()
			
			items = Rig.query().fetch()
            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
