//
//  AppStyle.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

private let defaultFontName = "Helvetica"
private let defaultFontBoldName = "HelveticaNeue-Bold"

struct BaseColors {
	static let green = 		UIColor.init(red: 0.21, green: 0.89, blue: 0.56, alpha: 1.0)
	static let blue =		UIColor.init(red: 0.00, green: 0.82, blue: 0.86, alpha: 1.0)
	static let gray = 		UIColor.init(red: 0.55, green: 0.52, blue: 0.50, alpha: 1.0)
	static let violet = 	UIColor.init(red: 0.600, green: 0.404, blue: 0.808, alpha: 1.00)
}

struct AppColors {
	static let primaryColor = BaseColors.green
	static let secudaryColor = BaseColors.blue
	
	static let firstTabColor = BaseColors.green
	static let secondTabColor = BaseColors.blue
	static let thirdTabColor = BaseColors.violet
}

struct AppFonts {
	static let defaultFont = UIFont(name: defaultFontName, size: AppFontSizes.defaultTextSize)
	static let mediumFont = UIFont(name: defaultFontName, size: AppFontSizes.mediumTextSize)
	static let bigFont = UIFont(name: defaultFontName, size: AppFontSizes.mediumTextSize)
	static let veryBigFont = UIFont(name: defaultFontName, size: AppFontSizes.mediumTextSize)
	
	static let defaultBoldFont = UIFont(name: defaultFontName, size: AppFontSizes.defaultTextSize)
	static let mediumBoldFont = UIFont(name: defaultFontName, size: AppFontSizes.mediumTextSize)
	static let bigBoldFont = UIFont(name: defaultFontName, size: AppFontSizes.mediumTextSize)
	static let veryBigBoldFont = UIFont(name: defaultFontName, size: AppFontSizes.mediumTextSize)
}

private struct AppFontSizes {
	static let defaultTextSize: CGFloat = 12.0
	static let mediumTextSize: CGFloat = 14.0
	static let bigTextSize: CGFloat = 16.0
	static let veryBigTextSize: CGFloat = 18.0
	static let fieldTextSize: CGFloat = 14.0
}

struct AppStyle {
	static let defaultLabelFont = AppFonts.defaultFont
	static let defaultLabelTextColor = UIColor.black

	static let sectionHeaderTitleFont = AppFonts.defaultFont
	static let sectionHeaderTitleColor = UIColor.white
	static let sectionHeaderBackgroundColor = UIColor.black
	static let sectionHeaderBackgroundColorHighlighted = UIColor.gray
	static let sectionHeaderAlpha: CGFloat = 1.0

	static let defaultSegmentedColor = BaseColors.blue

	static let defaultNavigationBarColor = UIColor.white
	static let defaultNavigationBarTitleColor = UIColor.black

	// Tabbar
	static let defaultTabBarColor = BaseColors.gray
	
	// MySkin TabBar
	static let mySkinTabBarTitleColor = AppColors.firstTabColor
	
	// Consult TabBar
	static let consultTabBarTitleColor = AppColors.secondTabColor
	
	// MyProfile TabBar
	static let profileBarTitleColor = AppColors.thirdTabColor
	
	static let profileNavigationBarColor = AppColors.thirdTabColor
	static let profileNavigationBarTitleColor = UIColor.white
	static let profileTopViewBackgroundColor = AppColors.thirdTabColor
	
	static let circularImageViewBorderColor = UIColor.white

	// Default TextField

	static let defaultTextFieldBackgroundColor = UIColor.white
	static let defaultTextFieldBorderColor = BaseColors.gray
	static let defaultTextFieldTextColor = BaseColors.gray
	static let defaultTextFieldError = UIColor.red
	static let defaultTextFieldPlaceHolderColor = UIColor.gray
	static let defaultTextFieldFont = AppFonts.defaultFont
	
	static let formTextFieldBorderActiveColor = AppColors.secudaryColor
	static let formTextFieldBorderInactiveColor = BaseColors.gray
	

	// Positive Button
	static let positiveButtonBackgroundColor = AppColors.primaryColor
	static let positiveButtonTextColor = UIColor.white

	// No Background Button
	static let noBackgroundButtonBackgroundColor = UIColor.clear
	static let noBackgroundButtonTextColor = UIColor.black
	static let noBackgroundButtonFont = AppFonts.defaultFont
}


