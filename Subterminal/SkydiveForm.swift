//
//  SkydiveFormController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit

class SkydiveForm: Form {

	public static let NOTIFICATION_NAME = "skydive_data_changed"

    override func viewDidLoad() {
        super.viewDidLoad()

		self.formView = SkydiveFormView.newAutoLayout()
		self.view.addSubview(self.getFormView())
    }
}
