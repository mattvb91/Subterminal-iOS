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

class DropzoneTableController: TableController {
	
    override func viewDidLoad() {
		self.canEditItems = false
		self.tableView.rowHeight = 70
		
        super.viewDidLoad()
    }

	override func configureViewCell(cell: UITableViewCell, item: Model) {
		let dropzone = item as? Dropzone
		let cell = cell as? DropzoneTableViewCell
		
		cell?.nameLabel.text = dropzone?.name
		cell?.countryLabel.text = dropzone?.country
    }
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let dropzoneController = DropzoneViewController()
		dropzoneController.item = items.object(at: indexPath.row) as? Dropzone
		
		self.navigationController?.pushViewController(dropzoneController, animated: true)
	}
	
	override func getViewCellIdentifier() -> String {
		return "dropzoneTableViewCell"
	}
	
	override func getAssignedModel() -> Model {
		return Dropzone()
	}
	
	override func getViewCellClass() -> DropzoneTableViewCell {
		return DropzoneTableViewCell()
	}
}
