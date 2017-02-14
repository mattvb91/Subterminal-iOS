//
//  SkydiveTableViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import os.log

class SkydiveTableViewController: UITableViewController {

    var skydives = [Skydive]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleSkydives()
		
		self.title = "Dropzones"
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	
	override func viewWillAppear(_ animated: Bool) {
		tableView.register(SkydiveTableViewCell.self, forCellReuseIdentifier: "skydiveTableViewCell")
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
        return skydives.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "skydiveTableViewCell", for: indexPath) as? SkydiveTableViewCell else {
                fatalError("The cell is not an instance of SkydiveTableViewCell")
        }
        
        let skydive = skydives[indexPath.row]
		
        // Configure the cell...
		cell.dropzone.text = "dropzone"
		
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
				os_log("Adding an item")
				break;
			case "show":
				os_log("Showing item")
				break;
			case "edit":
				os_log("Editing an item")
		
		default:
			os_log("Undefined controller action")
		}
    }

    
    //MARK: Private Methods
    private func loadSampleSkydives() {
        
        
        let skydive1 = Skydive()
        let skydive2 = Skydive()
        let skydive3 = Skydive()
        
        skydives += [skydive1, skydive2, skydive3]
        
    }

}
