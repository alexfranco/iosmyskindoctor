//
//  ThemeManager.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

struct ThemeManager {
	
	static func applyTheme() {
		
		// Status bar
		let sharedApplication = UIApplication.shared
		sharedApplication.statusBarStyle = .lightContent
		
		// Navigation bar
		UINavigationBar.appearance().barStyle = UIBarStyle.default
		UINavigationBar.appearance().barTintColor = AppStyle.defaultNavigationBarColor
		UINavigationBar.appearance().tintColor = AppStyle.defaultNavigationBarTitleColor
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : AppStyle.defaultNavigationBarTitleColor]
		
		// Label
		UILabel.appearance().font = AppStyle.defaultLabelFont
		UILabel.appearance().textColor = AppStyle.defaultLabelTextColor
				
		// Segmented control
		UISegmentedControl.appearance().tintColor = AppStyle.defaultSegmentedColor
		
		// TextFields
		UITextField.appearance().font = AppStyle.defaultTextFieldFont

		AkiraTextField.appearance().backgroundColor = AppStyle.defaultTextFieldBackgroundColor
		AkiraTextField.appearance().placeholderColor = AppStyle.defaultTextFieldPlaceHolderColor
		AkiraTextField.appearance().borderColor = AppStyle.defaultTextFieldPlaceHolderColor
				
		// Buttons
		PositiveButton.appearance().backgroundColor = AppStyle.positiveButtonBackgroundColor
		PositiveButton.appearance().tintColor = AppStyle.positiveButtonTextColor
		
		NoBackgroundButton.appearance().backgroundColor = AppStyle.noBackgroundButtonBackgroundColor
		NoBackgroundButton.appearance().tintColor = AppStyle.noBackgroundButtonTextColor
	}
}
