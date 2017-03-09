//
//  JumpTableController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import SharkORM

class JumpTableController: TableController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.rowHeight = 70
	}

	override func fetchQuery() -> SRKQuery {
		return super.fetchQuery().order(byDescending: "date, id")
	}
	
	override func getViewCellClass() -> JumpTableViewCell {
		return JumpTableViewCell()
	}
	
	override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let controller = JumpViewController()
		controller.item = items.object(at: indexPath.row) as? Jump
			
		self.navigationController?.pushViewController(controller, animated: true)
	}

	override func assignModelToController(controller: UIViewController) {
		let jumpForm = controller as? JumpForm
		jumpForm?.item = self.getAssignedModel()
	}
	
	override func getAssignedController() -> JumpForm {
		return JumpForm()
	}
	
	override func getAssignedModel() -> Jump {
		return Jump()
	}
	
	override func getViewCellIdentifier() -> String {
		return "jumpTableViewCell"
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.getViewCellIdentifier(), for: indexPath) as! JumpTableViewCell
	
		let jump = items.object(at: indexPath.row) as! Jump
		
		var position = indexPath.row
		if position == 0 {
			position = items.count
		} else {
			position = items.count - position
		}
	
		cell.thumb.image = nil
		cell.count.text = "#" + position.description
		cell.exitName.text = jump.exit()?.name
		
		if let image = Image.getThumbnailImageForEntity(entity: jump) as? Image {
			cell.thumb.image = image.getUIImage().thumbnailImage(50, transparentBorder:1, cornerRadius:5,interpolationQuality:CGInterpolationQuality.low)
		}
		
		cell.delay.text = nil
		if jump.delay != nil {
			cell.delay.text = "Delay: " + (jump.delay?.description)! + "s"
		}
		
		cell.slider.text = nil
		if jump.slider != nil {
			cell.slider.text = "Slider: " + jump.getFormattedSlider()!
		}
		
		if jump.date != nil {
			cell.timeAgo.text = DateHelper.timeAgoSince(date: jump.date!)
		}
		
		return cell
	}
}
