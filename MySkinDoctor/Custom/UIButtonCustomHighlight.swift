//
//  UIButtonCustomHighlight.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 03/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class UIButtonCustomHighlight: UIButton {

	var normalBackgroundColor = UIColor.red
	var hightlightBackgroundColor = UIColor.yellow
	
	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = normalBackgroundColor
	}
	
	override open var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? hightlightBackgroundColor : normalBackgroundColor
		}
	}
}
