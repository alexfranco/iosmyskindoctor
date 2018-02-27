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
	static var hospitalGreen: UIColor { return UIColor(red: 120.0 / 255.0, green: 219.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0) }
	static var amethyst: UIColor { return UIColor(red: 154.0 / 255.0, green: 99.0 / 255.0, blue: 209.0 / 255.0, alpha: 1.0) }
	static var orangeish: UIColor { return UIColor(red: 248.0 / 255.0, green: 142.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0) }
	static var blush: UIColor { return UIColor(red: 238.0 / 255.0, green: 114.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0) }
	static var skyBlue: UIColor { return UIColor(red: 77.0 / 255.0, green: 200.0 / 255.0, blue: 1.0, alpha: 1.0) }
	static var brownishGrey: UIColor { return UIColor(white: 110.0 / 255.0, alpha: 1.0) }
	static var white: UIColor { return UIColor(white: 240.0 / 255.0, alpha: 1.0) }
	static var whiteTwo: UIColor { return UIColor(white: 236.0 / 255.0, alpha: 1.0) }
	static var warmGrey: UIColor { return UIColor(white: 129.0 / 255.0, alpha: 1.0) }
	static var warmGreyTwo: UIColor { return UIColor(white: 113.0 / 255.0, alpha: 1.0) }
	static var warmGreyThree: UIColor { return UIColor(white: 132.0 / 255.0, alpha: 1.0) }
	static var black: UIColor { return UIColor(white: 46.0 / 255.0, alpha: 1.0) }
	static var greyishBrown: UIColor { return UIColor(white: 70.0 / 255.0, alpha: 1.0) }
	static var ice: UIColor { return UIColor(red: 239.0 / 255.0, green: 1.0, blue: 242.0 / 255.0, alpha: 1.0) }
	
	static var formGrey: UIColor { return UIColor(red: 210.0 / 255.0, green: 210.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0) }
}

struct AppColors {
	static let primaryColor = BaseColors.hospitalGreen
	static let secudaryColor = BaseColors.skyBlue
	
	static let firstTabColor = BaseColors.hospitalGreen
	static let secondTabColor = BaseColors.hospitalGreen
	static let thirdTabColor = BaseColors.amethyst
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

	static let defaultSegmentedColor = BaseColors.skyBlue

	static let defaultNavigationBarColor = UIColor.white
	static let defaultNavigationBarTitleColor = UIColor.black

	// Tabbar
	static let defaultTabBarColor = BaseColors.warmGrey
	
	// MySkin TabBar
	static let mySkinTabBarTitleColor = AppColors.firstTabColor
	
	static let mySkinDiagnosedColor = BaseColors.hospitalGreen
	static let mySkinUndiagnosedColor = BaseColors.blush
	
	static let mySkinTableSectionTextColor = UIColor.white
	static let mySkinTableSectionTextFont = AppFonts.defaultBoldFont
	
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
	static let defaultTextFieldBorderColor = BaseColors.formGrey
	static let defaultTextFieldTextColor = BaseColors.formGrey
	static let defaultTextFieldError = UIColor.red
	static let defaultTextFieldPlaceHolderColor = BaseColors.warmGrey
	static let defaultTextFieldFont = AppFonts.defaultFont
	
	static let formTextFieldBorderActiveColor = AppColors.secudaryColor
	static let formTextFieldBorderInactiveColor = BaseColors.warmGrey
	

	// Positive Button
	static let positiveButtonBackgroundColor = AppColors.primaryColor
	static let positiveButtonTextColor = UIColor.white

	// No Background Button
	static let noBackgroundButtonBackgroundColor = UIColor.clear
	static let noBackgroundButtonTextColor = UIColor.black
	static let noBackgroundButtonFont = AppFonts.defaultFont
}


