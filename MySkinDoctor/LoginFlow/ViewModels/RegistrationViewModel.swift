//
//  RegistrationViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class RegistrationViewModel: BaseViewModel {
	
	var email = ""
	var password = ""
	
	var emailValidationStatus: (()->())?
	var passwordValidationStatus: (()->())?
	
	var emailErrorMessage: String = "" {
		didSet {
			self.emailValidationStatus?()
		}
	}
	
	var passwordErrorMessage: String = "" {
		didSet {
			self.passwordValidationStatus?()
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
		
		if Validations.isValidPassword(testStr: password) {
			passwordErrorMessage = ""
		} else {
			passwordErrorMessage = String.init(format: NSLocalizedString("error_password_not_valid", comment: ""), minimunPasswordLength)
			isValid = false
		}
		
		return isValid
	}
	
	func registerUser() {
		
		if !self.validateForm() {
			return
		}
		
		self.isLoading = true

		ApiUtils.registration(email: email, password:password) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("registration success")
				
				let modelCast = model as! RegistrationResponseModel
				DataController.login(email: self.email, key: modelCast.key!)
				
				self.goNextSegue!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
}

