//
//  ProfileViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class ProfileViewModel: BaseViewModel {
	
	var email = ""
	var phone = ""
	
	var dob: Date {
		didSet {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yyyy"
			dobUpdated!(formatter.string(from: dob))
		}
	}
	
	var dobUpdated: ((_ date: String)->())?
	
	var addressLine1 = ""
	var addressLine2 = ""
	var town = ""
	var postcode = ""
	var gpName = ""
	var gpAccessCode = ""
	var isPermisionEnabled = false
	
	var emailValidationStatus: (()->())?
	
	var emailErrorMessage: String = "" {
		didSet {
			self.emailValidationStatus?()
		}
	}
	
	override func validateForm() -> Bool {
		var isValid = true
		
		if Validations.isValidEmail(testStr: email) {
			emailErrorMessage = ""
		} else {
			emailErrorMessage = NSLocalizedString("error_email_not_valid", comment: "")
			isValid = false
		}
		
		return isValid
	}
	
	override init() {
		dob = Date()
		super.init()
	}
	
	func saveModel() {
		
		if !self.validateForm() {
			return
		}
	}
}
