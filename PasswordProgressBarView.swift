//
//  PasswordProgressBarView.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class PasswordProgressBarView: UIProgressView {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	func setup() {
		self.progress = 0.0;
	}
	
	func updatePasswordStrength(strength: PasswordStrengthType) {
		switch strength {
		case PasswordStrengthType.empty:
			self.progress = 0.00
			self.tintColor = UIColor.red
		case PasswordStrengthType.noValidLength:
			self.progress = 0.10
			self.tintColor = UIColor.red
		case PasswordStrengthType.weak:
			self.progress = 0.50
			self.tintColor = UIColor.orange
		case PasswordStrengthType.moderate:
			self.progress = 0.75
			self.tintColor = UIColor.yellow
		case PasswordStrengthType.strong:
			self.progress = 1.0
			self.tintColor = UIColor.green
		}
	}
}
