//
//  SkydiveViewController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 16/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import ImagePicker
import ImageSlideshow

class SkydiveViewController: UIViewController, ImagePickerDelegate {

	var item: Skydive?
	let skydiveView = SkydiveView.newAutoLayout()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction))
		self.navigationItem.rightBarButtonItem = editButton

		if let item = item {
			skydiveView.skydive = item
			
			skydiveView.skydiveDescription.text = item.skydive_description
			skydiveView.skydiveDescription.sizeToFit()
			
			if let exitAltitude = item.exit_altitude {
				skydiveView.exitAlt.text = String(describing: exitAltitude)
			}
			
			if let deployAlt = item.deploy_altidude {
				skydiveView.deployAlt.text = String(describing: deployAlt)
			}
			
			if let delay = item.delay {
				skydiveView.delay.text = String(describing: delay)
			}
			
			if let rig = item.rig() {
				skydiveView.rig.text = (item.rig()?.container_manufacturer!)! + " - " + (item.rig()?.container_model!)!
			}
			skydiveView.dropzone.text = item.dropzone()?.name
			skydiveView.aircraft.text = item.aircraft()?.name
			skydiveView.type.text = item.getFormattedType()
			
			loadImages()
		}
		
		self.view.addSubview(skydiveView)
	}
	
	func editAction() {
		var formController = SkydiveForm()
		formController.item = self.item
		
		self.navigationController?.pushViewController(formController, animated: true)
	}
	
	func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
		
	}
	
	func loadImages() {
		var images = Image.getImagesForEntity(entity: self.item!)
		if images.count > 0 {
			var imageSources = [ImageSource]()
			
			for image in images {
				let image = image as? Image
				imageSources.append(ImageSource(image: image!.getUIImage()))
			}
			
			skydiveView.images.setImageInputs(imageSources)
			skydiveView.addSubview(skydiveView.images)
		}
	}
	
	func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
		imagePicker.dismiss(animated: true, completion: nil)
		
		for image in images {
			Image.createImageForEntity(entity: self.item!, uiImage: image)
		}
		
		loadImages()
		
		skydiveView.didSetupConstraints = false
		skydiveView.setNeedsUpdateConstraints()
	}
	
	func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
		imagePicker.dismiss(animated: true, completion: nil)
	}
}
