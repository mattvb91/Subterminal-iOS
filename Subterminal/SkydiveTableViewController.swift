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
		
		self.title = "Skydives"
		
        self.clearsSelectionOnViewWillAppear = false
		self.navigationItem.leftBarButtonItem = self.editButtonItem
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
    
    //MARK: Private Methods
    private func loadSampleSkydives() {
        
        
        let skydive1 = Skydive()
        let skydive2 = Skydive()
        let skydive3 = Skydive()
        
        skydives += [skydive1, skydive2, skydive3]
        
    }

}
