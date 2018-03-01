//
//  PositiveButton.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class PositiveButton: UIButton {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setTitleColor(AppStyle.positiveButtonTextColorDisable, for: .disabled)
	}
}
