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
	
	static let goToSetupWizard = "goToSetupWizard"
	static let goToSetupWizard2 = "goToSetupWizard2"
	static let goToSetupWizard3 = "goToSetupWizard3"
	
	static let goToAddSkinProblem = "goToAddSkinProblem"
	static let goToSkinProblemPhotoInformationViewController = "goToSkinProblemPhotoInformationViewController"
	static let goToSkinProblemLocationViewController = "goToSkinProblemLocationViewController"
	static let goToMedicalHistoryViewControler = "goToMedicalHistoryViewControler"
	static let goToSkinProblemThankYouViewControllerFromMedicalHistory = "goToSkinProblemThankYouViewControllerFromMedicalHistory"
	static let goToConfirmConsult = "goToConfirmConsult"
	static let goToThankYouViewController = "goToThankYouViewController"
	static let goToDiagnosis = "goToDiagnosis"
	static let goToDiagnosisUpdateRequest = "goToDiagnosisUpdateRequest"
	static let goToMySkinProblemDiagnoseUpdateRequest = "goToMySkinProblemDiagnoseUpdateRequest"
	static let goToMyConsultDetails = "goToMyConsultDetails"
	static let goToChangePasswordVC = "goToChangePasswordVC"
	static let goToBookAConsultNavigation = "goToBookAConsultNavigation"
	static let goToBookingConsult = "goToBookingConsult"
	
	static let unwindToAddSkinProblems = "unwindToAddSkinProblems"
	static let unwindToAddSkinProblemsFromPhoto = "unwindToAddSkinProblemsFromPhoto"
	static let unwindToMySkinProblems = "unwindToMySkinProblems"
}

struct Storyboard {
	static let mainStoryboardName = "Main"
	static let loginStoryboardName = "Login"
	static let mainTabNavigationControllerId = "MainTabNavigationController"
	static let loginNavigationControllerId = "loginNavigationControllerId"
}

struct UserDefaultConsts {
	static let isUserLoggedIn = "isUserLoggedIn"
	static let isFirstTime = "isFirstTime"
	static let email = "email"
}

struct CellId {
	static let mySkinProblemsCellId = "MySkinProblemsCellId"
	static let addPhotoTableViewCellId = "AddPhotoTableViewCellId"
	static let skinProblemTableViewCellId = "SkinProblemTableViewCellId"
	static let myConsultTableViewCellId = "MyConsultTableViewCellId"
	static let updateRequestCellId = "UpdateRequestCellId"
}

struct CoreData {
	static let dataBaseName = "MySkinDoctor"
}
