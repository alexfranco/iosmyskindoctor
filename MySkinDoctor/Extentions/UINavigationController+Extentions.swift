//
//  UINavigationController+Extentions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
	
	func setBackgroundColorWithoutShadowImage(bgColor: UIColor, titleColor: UIColor = UIColor.black) {
		navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor]
		navigationBar.tintColor = titleColor
		navigationBar.barTintColor = bgColor
		navigationBar.isTranslucent = false
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
	}
}
