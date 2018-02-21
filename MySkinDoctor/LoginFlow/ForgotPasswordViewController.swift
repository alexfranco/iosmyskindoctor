//
//  ForgotPasswordViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 20/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import TextFieldEffects
import UIKit
import ObjectMapper

class ForgotPasswordViewController: FormViewController {
	
	@IBOutlet weak var logoImageView: UIImageView!
	@IBOutlet weak var emailTextField: FormTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.placeholder = "Email"
		
		registerForKeyboardReturnKey([emailTextField])
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Hide the navigation bar on the this view controller
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		if !validateForm() {
			return
		}
		
		showSpinner(nil)
		nextButton.isEnabled = false
		ApiUtils.forgotPassword(email: emailTextField.text!) { (result) in
			self.nextButton.isEnabled = true
			self.hideSpinner()
			
			switch result {
			case .success(let model):
				self.handleResponseSuccess(model: model!)
			case .failure(let model, let error):
				self.handleResponseError(model: model as! BaseResponseModel, error: error)
			}
		}
	}
	
	func validateForm() -> Bool {
		var isValid = true
		
		if Validations.isValidEmail(testStr: emailTextField.text!) {
			emailTextField.errorMessage = ""
		} else {
			emailTextField.errorMessage = "The email is invalid"
			isValid = false
		}
		
		return isValid
	}
	
	func handleResponseSuccess(model: BaseMappable) {
		let title = NSLocalizedString("reset_password_success_title", comment: "Reset password")
		let message = NSLocalizedString("reset_password_success_message", comment: "Reset password successful")
		
		self.showAlertView(title: title, message: message) { (action) in
			self.navigationController?.popViewController(animated: true)
		}
	}
	
	func handleResponseError(model: BaseMappable, error: ApiUtils.ApiGenericError) {
		print(error)
		// Show error
		if let forgotPasswordResponseModel = model as? ForgotPasswordResposeModel, let firstEmailError =  forgotPasswordResponseModel.emailErrors.first {
			self.emailTextField.errorMessage = firstEmailError
		}
		else {
			// Generic error
			let title = NSLocalizedString("reset_password_error_generic_title", comment: "Reset password")
			let message = NSLocalizedString("reset_password_error_generic_message", comment: "Reset password successful")
			self.showAlertView(title: title, message: message)
		}
	}
}
