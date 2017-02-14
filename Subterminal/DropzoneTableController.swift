//
//  DropzoneTableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 12/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import SharkORM
import os.log

class DropzoneTableController: UITableViewController {

	var items: SRKResultSet = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

		items = Dropzone.query().fetchLightweight()
		self.tableView.rowHeight = 70
    }

	override func viewWillAppear(_ animated: Bool) {
		tableView.register(DropzoneTableViewCell.self, forCellReuseIdentifier: "dropzoneTableViewCell")
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "dropzoneTableViewCell", for: indexPath) as? DropzoneTableViewCell else {
			fatalError("Could not get cell")
		}

        // Configure the cell...
		let dropzone = items.object(at: indexPath.row) as? Dropzone
		
		cell.nameLabel.text = dropzone?.name
		cell.countryLabel.text = dropzone?.country

        return cell
    }
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let dropzoneController = DropzoneViewController()
		dropzoneController.item = items.object(at: indexPath.row) as? Dropzone
		
		self.navigationController?.pushViewController(dropzoneController, animated: true)
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
		switch(segue.identifier ?? "") {
		case "add":
			os_log("Adding an item", log: OSLog.default, type: .debug)
			break;
		case "show":
			
			os_log("showing an item", log: OSLog.default, type: .debug)
			
			guard let view = segue.destination as? DropzoneViewController else {
				fatalError("Unexpected destination: \(segue.destination)")
			}
			
			guard let selectedCell = sender as? DropzoneTableViewCell else {
				fatalError("Unexpected sender: \(sender)")
			}
			
			guard let indexPath = tableView.indexPath(for: selectedCell) else {
				fatalError("The selcted cell is not being displayed by the table")
			}
			
			view.item = items.object(at: indexPath.row) as? Dropzone
			
		default:
			os_log("Undefined controller action")
		}

    }
	

}
