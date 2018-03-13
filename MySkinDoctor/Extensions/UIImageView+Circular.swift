//
//  UIImageView+Circular.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
	
	func setRounded() {
		let radius = self.frame.width / 2
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
	}
	
	func setWhiteBorder() {
		self.layer.borderWidth = 5
		self.layer.borderColor = AppStyle.circularImageViewBorderColor.cgColor
	}
}
