//
//  Style.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

private struct Color {
	static var green = UIColor.init(red: 0.21, green: 0.89, blue: 0.56, alpha: 1.0)
	static var blue = UIColor.init(red: 0.00, green: 0.82, blue: 0.86, alpha: 1.0)
	static var gray = UIColor.init(red: 0.55, green: 0.52, blue: 0.50, alpha: 1.0)
}

struct AppColors {
	static var primaryColor = Color.green
	static var secudaryColor = Color.blue
}

private struct Font {
	static var defaultFont = UIFont(name: "Helvetica", size: FontSize.defaultTextSize)
}

private struct FontSize {
	static let defaultTextSize: CGFloat = 12.0
	static let fieldTextSize: CGFloat = 14.0
}

struct Style {
	
	static var defaultLabelFont = Font.defaultFont
	static var defaultLabelTextColor = UIColor.black
	
	static var sectionHeaderTitleFont = Font.defaultFont
	static var sectionHeaderTitleColor = UIColor.white
	static var sectionHeaderBackgroundColor = UIColor.black
	static var sectionHeaderBackgroundColorHighlighted = UIColor.gray
	static var sectionHeaderAlpha: CGFloat = 1.0
	
	static var defaultSegmentedColor = Color.blue
	
	static var defaultNavigationBarColor = UIColor.white
	static var defaultNavigationBarTitleColor = UIColor.black
	
	// Default TextField
	
	static var defaultTextFieldBackgroundColor = UIColor.white
	static var defaultTextFieldBorderColor = Color.gray
	static var defaultTextFieldTextColor = Color.gray
	static var defaultTextFieldError = UIColor.red
	static var defaultTextFieldPlaceHolderColor = UIColor.gray
	static var defaultTextFieldFont = Font.defaultFont
	
	// Positive Button
	static var positiveButtonBackgroundColor = AppColors.primaryColor
	static var positiveButtonTextColor = UIColor.white
	
	// No Background Button
	static var noBackgroundButtonBackgroundColor = UIColor.clear
	static var noBackgroundButtonTextColor = UIColor.black
	static var noBackgroundButtonFont = Font.defaultFont
}


