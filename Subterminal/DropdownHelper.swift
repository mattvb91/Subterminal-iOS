//
//  DropdownHelper.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 02/03/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import DropDown

extension DropDown {
	
	//Get an index for the Key from the dataSource values
	func selectRowForDataSourceWithKey(key: Int, data: [Int: Any], label: UILabel) {
		if let value = data[key] {
			let index = self.dataSource.index(of: value as! String)
			label.text = value as? String
			self.selectRow(at: index)
		}
	}
	
	func getKeyForDataFromSelectedRow(data: [Int: Any]) -> Int? {
		for (key, value) in data {
			if value as? String == self.selectedItem {
				return key
			}
		}
		
		return nil
	}
	
	func parseIdFromSelection() -> Int {
		var item = self.selectedItem?.components(separatedBy: "-")[0]
		item = item?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		
		return Int(item!)!
	}
}

class DropdownKeyCell: DropDownCell {
	var key: Int?
}
