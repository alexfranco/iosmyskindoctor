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
	
		BoldLabel.appearance().font = AppFonts.defaultBoldFont
		BoldLabel.appearance().textColor = AppStyle.defaultLabelTextColor
		
		TitleLabel.appearance().font = AppFonts.bigBoldFont
		TitleLabel.appearance().textColor = AppStyle.defaultLabelTextColor
		
		GrayLabel.appearance().font = AppFonts.defaultFont
		GrayLabel.appearance().textColor = BaseColors.warmGrey
		
		// Segmented control
		UISegmentedControl.appearance().tintColor = AppStyle.defaultSegmentedColor
		UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
		UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.defaultSegmentedColor], for: .normal)
		
		// TextFields
		UITextField.appearance().tintColor = AppStyle.defaultTextFieldTextColor
		UITextField.appearance().font = AppStyle.defaultTextFieldFont
				
		// TextViews
		FormTextView.appearance().font = AppStyle.defaultTextFieldFont
		FormTextView.appearance().textColor = AppStyle.defaultTextViewTextColor
		FormTextView.appearance().placeholderTextColor = AppStyle.defaultTextViewPlaceHolderColor
		
		ProfileTextField.appearance().backgroundColor = AppStyle.defaultTextFieldBackgroundColor
		ProfileTextField.appearance().placeholderColor = AppStyle.defaultTextFieldPlaceHolderColor
		
		// Buttons
		PositiveButton.appearance().backgroundColor = AppStyle.positiveButtonBackgroundColor
		PositiveButton.appearance().tintColor = AppStyle.positiveButtonTextColor
		
		NoBackgroundButton.appearance().backgroundColor = AppStyle.noBackgroundButtonBackgroundColor
		NoBackgroundButton.appearance().tintColor = AppStyle.noBackgroundButtonTextColor
	}
}
