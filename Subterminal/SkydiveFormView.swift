//
//  SkydiveFormView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 15/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveFormView: UIView {

	var didSetupConstraints: Bool = false

	var dropzoneLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		dropzoneLabel.text = "Dropzone"
	
		self.addSubview(dropzoneLabel)
		setNeedsUpdateConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		if(!didSetupConstraints) {
			self.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
			
			dropzoneLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
			dropzoneLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 80)
			
			self.didSetupConstraints = true
		}
		
		super.updateConstraints()
	}
}
