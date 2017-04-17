//
//  SkydiveTableViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import os.log
import SharkORM

class SkydiveTableViewController: TableController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
				
        self.clearsSelectionOnViewWillAppear = false
		
		self.tableView.rowHeight = 80
    }

	override func fetchQuery() -> SRKQuery {
		return super.fetchQuery().order(by: "date DESC,id DESC")
	}

	override func getViewCellIdentifier() -> String {
		return "skydiveTableViewCell"
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.getViewCellIdentifier(), for: indexPath) as? SkydiveTableViewCell
		
		let item = items.object(at: indexPath.row) as? Skydive
		
		var position = indexPath.row
		if position == 0 {
			position = items.count
		} else {
			position = items.count - position
		}
		
		if UserDefaults.standard.object(forKey: SettingsController.DEFAULT_SKYDIVE_COUNT) != nil {
			position += UserDefaults.standard.integer(forKey: SettingsController.DEFAULT_SKYDIVE_COUNT) - 1
		}
		
        // Configure the cell...
		cell?.dropzone.text = item?.dropzone()?.name
		cell?.aircraft.text = item?.aircraft()?.name
		cell?.count.text = "#" + position.description

		if let image = Image.getThumbnailImageForEntity(entity: item!) as? Image {
			cell?.thumb.image = image.getUIImage().thumbnailImage(50, transparentBorder:1, cornerRadius:5,interpolationQuality:CGInterpolationQuality.low)
		}
		
		cell?.delay.text = nil
		if item?.delay != nil {
			cell?.delay.text = (item?.delay?.stringValue)! + "s"
		}
		
		if item?.date != nil {
			cell?.timeAgo.text = DateHelper.timeAgoSince(date: (item?.date)!)
		}
		
		cell?.synced.setSyncedStatus(status: (item?.synced)!)
		
		return cell!
    }
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let skydiveController = SkydiveViewController()
		skydiveController.item = items.object(at: indexPath.row) as? Skydive
		
		self.navigationController?.pushViewController(skydiveController, animated: true)
	}
	
	override func getAssignedModel() -> Skydive {
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
