//
//  Consts.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 20/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
struct Consts {
}

struct Segues {
	static let goToMainStoryboardFromLogin = "goToMainStoryboardFromLogin"
	static let goToMainStoryboardFromSignUp = "goToMainStoryboardFromSignUp"
	static let goToSkinProblemPhotoInformationViewController = "goToSkinProblemPhotoInformationViewController"
	static let goToSkinProblemLocationViewController = "goToSkinProblemLocationViewController"
	static let goToMedicalHistoryViewControler = "goToMedicalHistoryViewControler"
	static let goToSkinProblemThankYouViewControllerFromMedicalHistory = "goToSkinProblemThankYouViewControllerFromMedicalHistory"
	static let goToSkinProblemThankYouViewControllerFromAddSkinProblem = "goToSkinProblemThankYouViewControllerFromAddSkinProblem"
	static let unwindToAddSkinProblemsWithSegue = "unwindToAddSkinProblemsWithSegue"
	
}

struct Storyboard {
	static let mainStoryboardName = "Main"
	static let mainTabNavigationControllerId = "MainTabNavigationController"
}

struct UserDefaultConsts {
	static let isUserLoggedIn = "isUserLoggedIn"	
}

struct CellId {
	static let mySkinProblemsCellId = "MySkinProblemsCellId"
	static let addPhotoTableViewCellId = "AddPhotoTableViewCellId"
	static let skinProblemTableViewCellId = "SkinProblemTableViewCellId"
	static let myConsultTableViewCellId = "MyConsultTableViewCellId"
}

