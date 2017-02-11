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

	var items: SRKResultSet?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
		
		loadData(notification: nil);
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
	
	func loadData(notification: NSNotification?) {
		items = Rig.query().fetch()
		self.tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (items?.count)!
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "rigTableViewCell", for: indexPath) as? RigTableViewCell else {
			fatalError("Could not get cell")
		}

        // Configure the cell...
		let rig = items?.object(at: indexPath.row) as? Rig
		
		cell.containerModelLabel.text = rig?.container_model
		
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	
    // MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		
		switch(segue.identifier ?? "") {
			case "add":
				os_log("Adding an item", log: OSLog.default, type: .debug)
				break;
			case "show":
				os_log("Showing item", log: OSLog.default, type: .debug)
				break;
			case "edit":
			
				os_log("Editing an item", log: OSLog.default, type: .debug)
			
				guard let gearForm = segue.destination as? GearForm else {
					fatalError("Unexpected destination: \(segue.destination)")
				}
			
				guard let selectedGearCell = sender as? RigTableViewCell else {
					fatalError("Unexpected sender: \(sender)")
				}
				
				guard let indexPath = tableView.indexPath(for: selectedGearCell) else {
					fatalError("The selcted cell is not being displayed by the table")
				}
				
				gearForm.item = items?.object(at: indexPath.row) as? Rig
			
		default:
			os_log("Undefined controller action")
		}
	}

}
