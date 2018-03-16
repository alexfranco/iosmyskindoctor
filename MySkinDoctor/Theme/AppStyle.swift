//
//  AppStyle.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

//private let defaultFontName = "SFProText-Regular"
//private let defaultFontBoldName = "SFProText-Semibold"

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
	static var warmGreyFour: UIColor { return UIColor(red: 115.0 / 255.0, green: 115.0 / 255.0, blue: 115.0 / 255.0, alpha: 1.0) }
	static var black: UIColor { return UIColor(white: 46.0 / 255.0, alpha: 1.0) }
	static var greyishBrown: UIColor { return UIColor(white: 70.0 / 255.0, alpha: 1.0) }
	static var ice: UIColor { return UIColor(red: 239.0 / 255.0, green: 1.0, blue: 242.0 / 255.0, alpha: 1.0) }
	
	static var formGrey: UIColor { return UIColor(red: 210.0 / 255.0, green: 210.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0) }
	
	static var tableViewGrey: UIColor { return UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0) }
	
	static var brightBlue: UIColor { return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0) }
}

struct AppColors {
	static let primaryColor = BaseColors.hospitalGreen
	static let secudaryColor = BaseColors.skyBlue
	
	static let firstTabColor = BaseColors.hospitalGreen
	static let secondTabColor = BaseColors.skyBlue
	static let thirdTabColor = BaseColors.amethyst
}

struct AppFonts {
//	static let smallFont = UIFont(name: defaultFontMediumName, size: AppFontSizes.smallTextSize)
//	static let defaultFont = UIFont(name: defaultFontMediumName, size: AppFontSizes.defaultTextSize)
//	static let mediumFont = UIFont(name: defaultFontMediumName, size: AppFontSizes.mediumTextSize)
//	static let bigFont = UIFont(name: defaultFontMediumName, size: AppFontSizes.mediumTextSize)
//	static let veryBigFont = UIFont(name: defaultFontMediumName, size: AppFontSizes.mediumTextSize)
//
//	static let defaultBoldFont = UIFont(name: defaultFontBoldName, size: AppFontSizes.defaultTextSize)
//	static let mediumBoldFont = UIFont(name: defaultFontBoldName, size: AppFontSizes.mediumTextSize)
//	static let bigBoldFont = UIFont(name: defaultFontBoldName, size: AppFontSizes.mediumTextSize)
//	static let veryBigBoldFont = UIFont(name: defaultFontBoldName, size: AppFontSizes.mediumTextSize)
	
	static let smallFont = UIFont.systemFont(ofSize: AppFontSizes.smallTextSize)
	static let defaultFont = UIFont.systemFont(ofSize: AppFontSizes.defaultTextSize)
	static let mediumFont = UIFont.systemFont(ofSize: AppFontSizes.mediumTextSize)
	static let bigFont = UIFont.systemFont(ofSize: AppFontSizes.bigTextSize)
	static let veryBigFont = UIFont.systemFont(ofSize: AppFontSizes.veryBigTextSize)
	
	static let defaultBoldFont = UIFont.boldSystemFont(ofSize: AppFontSizes.defaultTextSize)
	static let mediumBoldFont = UIFont.boldSystemFont(ofSize: AppFontSizes.mediumTextSize)
	static let bigBoldFont = UIFont.boldSystemFont(ofSize: AppFontSizes.bigTextSize)
	static let veryBigBoldFont = UIFont.boldSystemFont(ofSize: AppFontSizes.veryBigTextSize)
}

private struct AppFontSizes {
	static let defaultTextSize: CGFloat = 12.0
	static let smallTextSize: CGFloat = 10.0
	static let mediumTextSize: CGFloat = 14.0
	static let bigTextSize: CGFloat = 16.0
	static let veryBigTextSize: CGFloat = 18.0
	static let fieldTextSize: CGFloat = 12.0
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
	
	// Add Skin Problem
	
	static let mySkinProblemsDiagnoseTableViewBackground = BaseColors.tableViewGrey
	static let mySkinProblemsUndiagnoseTableViewBackground = UIColor.white
	
	static let addSkinProblemInfoViewTextColor = UIColor.white
	static let addSkinProblemUndiagnosedViewBackground = BaseColors.amethyst
	static let addSkinProblemDiagnosedViewBackground = BaseColors.hospitalGreen
	static let addSkinProblemDiagnosedUpdateRequestViewBackground = BaseColors.orangeish
	static let addSkinProblemDiagnosedFollowUpViewBackground = BaseColors.orangeish
	
	// Add Skin Photo
	
	static let addSkinPhotoEditTextColor = AppColors.secudaryColor
	static let addSkinPhotoBodyButtonBackgroundColor = BaseColors.amethyst
	static let addSkinPhotoDocumentButtonBackgroundColor = BaseColors.skyBlue
	
	// Skin Problem Location
	static let locationNavigationBarBackgroundColor = BaseColors.amethyst
	static let locationSegmentedControlTint = UIColor.white
	static let locationSegmentedControlSelectedTextColor = BaseColors.amethyst
	static let locationSegmentedControlUnselectedTextColor = UIColor.white
	static let locationBackgroundColor = BaseColors.amethyst
	static let locationTextColor = UIColor.white
	
	// Skin Problem Diagnose
	static let diagnoseViewBackgroundColor = BaseColors.hospitalGreen
	static let diagnoseUpdateRequestViewBackgroundColor = BaseColors.orangeish
	static let diagnoseViewTextColor = UIColor.white
	static let diagnoseTitleColor = AppColors.secondTabColor
	static let diagnoseNextButtonColor = AppColors.secondTabColor
	
	// Medical History
	
	static let medicalHistorySaveViewBackgroundColor = BaseColors.ice
	static let medicalHistorySaveLabelTextColor = BaseColors.hospitalGreen
	
	static let thankYouBackground = BaseColors.hospitalGreen
	static let thankYouTextColor = BaseColors.white
	
	// Consult TabBar
	static let consultTabBarTitleColor = AppColors.secondTabColor
	
	static let consultTableViewHeaderBGColor = AppColors.secondTabColor
	static let consultTableViewHeaderBGColorDisabled = BaseColors.white
	static let consultTableViewHeaderTextColor = BaseColors.white
	static let consultTableViewHeaderTextColorDisabled = BaseColors.warmGreyTwo
	
	static let consultTableViewCellTimeBackgroundColor = BaseColors.hospitalGreen
	static let consultTableViewCellTimeBackgroundColorDisabled = UIColor.clear
	static let consultTableViewCellTextColor = BaseColors.white
	static let consultTableViewCellTextColorDisabled = UIColor.black
	static let consultTableSectionTextFont = AppFonts.defaultBoldFont
	
	static let consultNextButtonBackgroundColor = AppColors.secondTabColor

	// Calendar
	
	static let consultCalendarFont = AppFonts.defaultFont
	
	static let consultCalendarHeaderBackgroundColor = AppColors.secondTabColor
	static let consultCalendarHeaderTextColor = UIColor.white
	
	static let consultCalendarPresentBackgroundColor = AppColors.primaryColor
	static let consultCalendarPresentTextColor = UIColor.black
	
	static let consultCalendarDayBackgroundColor = UIColor.clear
	static let consultCalendarDayTextColor = UIColor.black
	
	static let consultCalendarSelectedDayBackgroundColor = AppColors.primaryColor
	static let consultCalendarSelectedDayTextColor = UIColor.white

	// Consult Confirm
	static let consultConfirmHighligthedLabelTextColor = AppColors.secondTabColor
	
	// Consult ThankYou
	static let consultThankYouViewBackgroundColor = AppColors.primaryColor
	static let consultThankYouViewTextColor = UIColor.white
	static let consultThankYouProfileViewBackgroundColor = UIColor.white
	static let consultThankYouAppointmentViewBackgroundColor = BaseColors.white
	static let consultThankYouTextColor = AppColors.secudaryColor
	
	// MyConsultTableViewCellView
	static let myConsultTableViewCellUpcomingBackground = UIColor.white
	static let myConsultTableViewCellHistoryBackground = BaseColors.tableViewGrey
	
	// MyProfile TabBar	
	static let profileBarTitleColor = AppColors.thirdTabColor
	
	static let profileNavigationBarColor = AppColors.thirdTabColor
	static let profileNavigationBarTitleColor = UIColor.white
	static let profileTopViewBackgroundColor = AppColors.thirdTabColor
	
	static let circularImageViewBorderColor = UIColor.white
	
	static let changePasswordButtonTitleColor = BaseColors.brightBlue
	static let logoutButtonTitleColor = BaseColors.blush

	// Default TextField

	static let defaultTextFieldBackgroundColor = UIColor.white
	static let defaultTextFieldBorderColor = BaseColors.formGrey
	static let defaultTextFieldTextColor = BaseColors.warmGreyFour
	static let defaultTextFieldError = UIColor.red
	static let defaultTextFieldPlaceHolderColor = BaseColors.warmGreyThree
	static let defaultTextFieldFont = AppFonts.defaultFont
	
	static let formTextFieldBorderActiveColor = AppColors.secudaryColor
	static let formTextFieldBorderInactiveColor = BaseColors.warmGrey
	
	// Default TextView
	static let defaultTextViewTextColor = BaseColors.black
	static let defaultTextViewPlaceHolderColor = BaseColors.brownishGrey
	
	// Positive Button
	static let positiveButtonBackgroundColor = AppColors.primaryColor
	static let positiveButtonTextColor = UIColor.white
	static let positiveButtonTextColorDisable = BaseColors.formGrey

	// Change Password
	static let changePasswordNextButtonTitleColor = UIColor.white
	static let changePasswordNextButtonBackgroundColor = BaseColors.skyBlue
	
	// No Background Button
	static let noBackgroundButtonBackgroundColor = UIColor.clear
	static let noBackgroundButtonTextColor = UIColor.black
	static let noBackgroundButtonFont = AppFonts.defaultFont
	
	// Wizard
	static let wizardNHSButtonColor = BaseColors.skyBlue 
	static let wizardSelfPayButtonColor = BaseColors.hospitalGreen
	
	static let profileImageViewPlaceHolder = BaseColors.brownishGrey
}


