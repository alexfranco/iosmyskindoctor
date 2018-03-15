//
//  UITextField+Padding.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
	
	func addLeftPadding() {
		let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
		leftView = paddingView
		leftViewMode = .always
	}
	
}
