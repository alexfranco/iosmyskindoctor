//
//  UILabel+RoundedBorders.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	
	func setRounded() {
		layer.masksToBounds = true
		layer.cornerRadius = 5
	}
}

