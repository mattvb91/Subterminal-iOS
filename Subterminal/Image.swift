//
//  Image.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 26/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import SharkORM

class Image: Synchronizable {
	
	dynamic var filename: String?
	dynamic var entity_type,
		entity_id: NSNumber?
	
	static let ENTITY_TYPE_EXIT = 0
	static let ENTITY_TYPE_JUMP = 1;
	static let ENTITY_TYPE_SKYDIVE = 2;
	static let ENTITY_TYPE_SIGNATURE = 3;
	
	static func createImageForEntity(entity: Model, uiImage: UIImage) {
		let image = Image()
		image.entity_type = NSNumber(value: getEntityTypeFromModel(entity: entity))
		image.entity_id = entity.id
		
		if let data = UIImagePNGRepresentation(uiImage) {
			let randomNum:UInt32 = arc4random_uniform(1000)

			let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			let filename = entity.id.description + "_" + (image.entity_type?.description)! + "_" + Int(randomNum).description + ".png"
			let path = docDir.appendingPathComponent(filename)
			try? data.write(to: path)
			image.filename = filename
			_ = image.save()
			
			entity.sendModelNotification()
		}
	}
	
	//Check the instance type and return
	static func getEntityTypeFromModel(entity: Model) -> Int {
		if entity is Skydive {
			return ENTITY_TYPE_SKYDIVE
		} else if entity is Jump {
			return ENTITY_TYPE_JUMP
		}
		
		return -1
	}
	
	static func getImagesForEntity(entity: Model) -> [Image] {
		var res = [Image]()
		
		for image in Image.query().where(withFormat: "entity_type = %@ AND entity_id = %@", withParameters: [getEntityTypeFromModel(entity: entity), entity.id]).fetch() {
			res.append(image as! Image)
		}
		
		return res
	}
	
	static func getThumbnailImageForEntity(entity: Model) -> Any? {
		let res = Image.query().where(withFormat: "entity_type = %@ AND entity_id = %@", withParameters: [getEntityTypeFromModel(entity: entity), entity.id]).limit(1).fetch()
		
		if (res?.count)! > 0 {
			return (res!.firstObject as? Image)!
		}
		
		return nil
	}
	
	func getUIImage() -> UIImage {
		var docDir        = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
		let docDirPath    = docDir[0]
		let pathForImage  = docDirPath + "/" + (self.filename)!
		
		return UIImage(contentsOfFile: pathForImage)!
	}
}
