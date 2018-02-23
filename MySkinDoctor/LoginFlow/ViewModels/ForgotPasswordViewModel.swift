//
//  ForgotPasswordViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class ForgotPasswordViewModel: BaseViewModel {
	
	var email = ""
	
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
	
	func requestPassword() {
		
		if !self.validateForm() {
			return
		}
		
		self.isLoading = true
		
		ApiUtils.forgotPassword(email: email) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("forgot password success")
				self.goNextSegue!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
}
