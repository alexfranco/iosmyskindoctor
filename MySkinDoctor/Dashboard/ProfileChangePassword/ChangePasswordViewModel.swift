//
//  ChangePasswordViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 16/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordViewModel: BaseViewModel {
	
	var oldPassword = ""
	var newPassword = ""
	var confirmPassword = ""
	
	var oldPasswordValidationStatus: (()->())?
	var newPasswordValidationStatus: (()->())?
	var confirmPasswordValidationStatus: (()->())?
	
	var oldPasswordErrorMessage: String = "" {
		didSet {
			self.oldPasswordValidationStatus?()
		}
	}
	
	var newPasswordErrorMessage: String = "" {
		didSet {
			self.newPasswordValidationStatus?()
		}
	}
	
	var confirmPasswordErrorMessage: String = "" {
		didSet {
			self.confirmPasswordValidationStatus?()
		}
	}
	
	override func validateForm() -> Bool {
		var isValid = true
		
		if Validations.isValidPassword(testStr: oldPassword) {
			oldPasswordErrorMessage = ""
		} else {
			oldPasswordErrorMessage = String.init(format: NSLocalizedString("error_password_not_valid", comment: ""), minimunPasswordLength)
			isValid = false
		}
		
		if Validations.isValidPassword(testStr: newPassword) {
			newPasswordErrorMessage = ""
		} else {
			newPasswordErrorMessage = String.init(format: NSLocalizedString("error_password_not_valid", comment: ""), minimunPasswordLength)
			isValid = false
		}
		
		if Validations.isValidPassword(testStr: confirmPassword) {
			confirmPasswordErrorMessage = ""
		} else {
			confirmPasswordErrorMessage = String.init(format: NSLocalizedString("error_password_not_valid", comment: ""), minimunPasswordLength)
			isValid = false
		}
		
		if newPassword == confirmPassword {
			newPasswordErrorMessage = ""
			confirmPasswordErrorMessage = ""
		} else {
			newPasswordErrorMessage = String.init(format: NSLocalizedString("change_passowrd_new_and_confirm_are_different", comment: ""), minimunPasswordLength)
			confirmPasswordErrorMessage = String.init(format: NSLocalizedString("change_passowrd_new_and_confirm_are_different", comment: ""), minimunPasswordLength)
			isValid = false
		}
		
		return isValid
	}
	
	var didSaveChanges: (()->())?
	
	func changePassword() {
		
		if !self.validateForm() {
			return
		}
		
//		self.isLoading = true
		
//		ApiUtils.changePassword(oldPassword: oldPassword, newPassword: newPassword, confirmPassowrd: confirmPassword, completionHandler: { (result) in
//			self.isLoading = false
//
//			switch result {
//			case .success(_):
//				print("change password success")
				self.didSaveChanges!()
//			case .failure(let model, let error):
//				print("error")
//				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
//			}
//		})
	}
}
