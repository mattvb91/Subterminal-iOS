//
//  JumpViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 28/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import ImagePicker
import AlamofireImage
import ImageSlideshow

class JumpViewController: UIViewController, ImagePickerDelegate {
	
	var item: Jump!
	var jumpView = JumpView.newAutoLayout()
	
	deinit {
		self.jumpView.images.setImageInputs([])
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))
		self.navigationItem.rightBarButtonItem = editButton
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.viewDidLoad), name: NSNotification.Name(rawValue: Jump.getNotificationName()), object: nil)

		jumpView.exit.text = item.exit()?.name
		jumpView.delay.text = item.delay?.description
		jumpView.pc.text = item.pc_size?.description
		jumpView.slider.text = item.getFormattedSlider()
		jumpView.jumpDescription.text = item.jump_description
		jumpView.jumpDescription.sizeToFit()
		jumpView.type.text = item.getFormattedType()
		jumpView.jump = item
		jumpView.rig.text = item.rig()?.getDisplayString()
		
		loadImages()
		
		self.view.addSubview(jumpView)
	}
	
	
	func editAction() {
		let formController = JumpForm()
		formController.item = self.item
		
		self.navigationController?.pushViewController(formController, animated: true)
	}
	
	func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
		
	}
	
	func loadImages() {
		let images = Image.getImagesForEntity(entity: self.item!)
		if images.count > 0 {
			var imageSources = [ImageSource]()
			
			for image in images {
				let image = image
				imageSources.append(ImageSource(image: image.getUIImage()))
			}
			
			jumpView.images.setImageInputs(imageSources)
			jumpView.scrollView.addSubview(jumpView.images)
		}
	}
	
	func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
		imagePicker.dismiss(animated: true, completion: nil)
		
		for image in images {
			Image.createImageForEntity(entity: self.item!, uiImage: image)
		}
		
		loadImages()
		
		jumpView.didSetupConstraints = false
		jumpView.setNeedsUpdateConstraints()
	}
	
	func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
		imagePicker.dismiss(animated: true, completion: nil)
	}
}
