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

class DropzoneTableController: TableController, UISearchResultsUpdating, UISearchBarDelegate {
	
	let searchController = UISearchController(searchResultsController: nil)
	
    override func viewDidLoad() {
		self.canEditItems = false
		self.tableView.rowHeight = 70
		
		configureSearchController()
		
        super.viewDidLoad()
    }
	
	func configureSearchController() {
		// Initialize and perform a minimum configuration to the search controller.
		searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search here..."
		searchController.searchBar.delegate = self
		searchController.searchBar.sizeToFit()
		
		// Place the search bar view to the tableview headerview.
		self.tableView.tableHeaderView = searchController.searchBar
	}

	public func updateSearchResults(for searchController: UISearchController) {
		let search = searchController.searchBar.text?.lowercased()
		
		if(Int((search?.characters.count)!) > 2) {
			self.items = type(of: getAssignedModel()).query().where(withFormat: "lower(name) LIKE %@", withParameters: [makeLikeParameter(search)]).fetch()
			self.tableView.reloadData()
		}
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.text = nil
		searchBar.showsCancelButton = false
		
		// Remove focus from the search bar.
		searchBar.endEditing(true)
		loadData(notification: nil)
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
