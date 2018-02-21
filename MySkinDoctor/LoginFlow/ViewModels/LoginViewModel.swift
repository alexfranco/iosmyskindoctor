//
//  LoginViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 21/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject {
	
	var email = ""
	var password = ""
	
	var updateLoadingStatus: (()->())?
	var showAlert: ((_ title: String, _ message: String) -> ())?
	var showResponseErrorAlert: ((_ responseModel: BaseResponseModel?, _ apiGenericError: ApiUtils.ApiGenericError)  -> ())?
	var goNextSegue: (()->())?
	
	var emailValidationStatus: (()->())?
	var passwordValidationStatus: (()->())?
	
	var isLoading: Bool = false {
		didSet {
			self.updateLoadingStatus?()
		}
	}
	
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
	
	func validateForm() -> Bool {
		var isValid = true

		if Validations.isValidEmail(testStr: email) {
			emailErrorMessage = ""
		} else {
			emailErrorMessage = "The email is invalid"
			isValid = false
		}

		if Validations.isValidPassword(testStr: password) {
			passwordErrorMessage = ""
		} else {
			passwordErrorMessage = "The password is invalid"
			isValid = false
		}

		return isValid
	}
	
	func loginUser() {
		
		if !self.validateForm() {
			return
		}
		
		self.isLoading = true
		
		ApiUtils.login(email: email, password:password) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("login success")
				
				// TODO save token
				let defaults = UserDefaults.standard
				defaults.set(true, forKey: UserDefaultConsts.isUserLoggedIn)
				self.goNextSegue!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
		
	}
	
}

