//
//  ShadowView.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 17/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class ShadowView: UIView {
	/// The corner radius of the `ShadowView`
	var cornerRadius: CGFloat = 5.0
	
	/// The shadow color of the `ShadowView`
	var shadowColor: UIColor = UIColor.black
	
	/// The shadow offset of the `ShadowView`
	var shadowOffset: CGSize = CGSize(width: 0.0, height: 2)
	
	/// The shadow radius of the `ShadowView`
	var shadowRadius: CGFloat = 3.0
	
	/// The shadow opacity of the `ShadowView`
	var shadowOpacity: Float = 0.3
	
	/**
	Masks the layer to it's bounds and updates the layer properties and shadow path.
	*/
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.layer.masksToBounds = false
		
		self.updateProperties()
		self.updateShadowPath()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/**
	Updates all layer properties according to the public properties of the `ShadowView`.
	*/
	fileprivate func updateProperties() {
		self.layer.cornerRadius = self.cornerRadius
		self.layer.shadowColor = self.shadowColor.cgColor
		self.layer.shadowOffset = self.shadowOffset
		self.layer.shadowRadius = self.shadowRadius
		self.layer.shadowOpacity = self.shadowOpacity
		self.layer.backgroundColor = UIColor.white.cgColor
	}
	
	/**
	Updates the bezier path of the shadow to be the same as the layer's bounds, taking the layer's corner radius into account.
	*/
	fileprivate func updateShadowPath() {
		self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
	}
	
	/**
	Updates the shadow path everytime the views frame changes.
	*/
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.updateShadowPath()
	}
}


