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
		UINavigationBar.appearance().barTintColor = Style.defaultNavigationBarColor
		UINavigationBar.appearance().tintColor = Style.defaultNavigationBarColor
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : Style.defaultNavigationBarTitleColor]
		
		// Label
		UILabel.appearance().font = Style.defaultLabelFont
		UILabel.appearance().textColor = Style.defaultLabelTextColor
				
		// Segmented control
		UISegmentedControl.appearance().tintColor = Style.defaultSegmentedColor
		
		// TextFields
		UITextField.appearance().font = Style.defaultTextFieldFont

		AkiraTextField.appearance().backgroundColor = Style.defaultTextFieldBackgroundColor
		AkiraTextField.appearance().placeholderColor = Style.defaultTextFieldPlaceHolderColor
		AkiraTextField.appearance().borderColor = Style.defaultTextFieldPlaceHolderColor
				
		// Buttons
		PositiveButton.appearance().backgroundColor = Style.positiveButtonBackgroundColor
		PositiveButton.appearance().tintColor = Style.positiveButtonTextColor
		
		NoBackgroundButton.appearance().backgroundColor = Style.noBackgroundButtonBackgroundColor
		NoBackgroundButton.appearance().tintColor = Style.noBackgroundButtonTextColor
	}
}
