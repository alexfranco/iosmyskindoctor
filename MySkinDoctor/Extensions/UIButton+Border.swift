//
//  UIButton+Border.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	func setBorder() {
		self.layer.borderWidth = 2.0
		self.layer.borderColor = self.titleColor(for: .normal)?.cgColor
	}
}

