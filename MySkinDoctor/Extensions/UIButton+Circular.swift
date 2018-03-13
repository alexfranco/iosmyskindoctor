//
//  UIButton+Circular.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	func setRounded() {
		self.layer.cornerRadius = 6
		self.layer.masksToBounds = true
	}
}

