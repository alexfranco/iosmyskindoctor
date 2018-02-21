//
//  RegistrationViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 14/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import TextFieldEffects
import UIKit

class RegistrationViewController: FormViewController {
	
	@IBOutlet weak var logoImageView: UIImageView!
	@IBOutlet weak var emailTextField: FormTextField!
	@IBOutlet weak var passwordTextField: FormTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.placeholder = "Email"
		passwordTextField.placeholder = "Password"
		
		registerForKeyboardReturnKey([emailTextField, passwordTextField])
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
		ApiUtils.registration(email: emailTextField.text!, password: passwordTextField.text!, firstName: "", lastName: "", dob: Date(), mobileNumber: "", postcode: "", deviceID: "") { (result) in
			self.hideSpinner()
			self.nextButton.isEnabled = true
			
			switch result {
			case .success(let model):
				print("sign up success")
				self.performSegue(withIdentifier: Segues.goToMainStoryboardFromLogin, sender: nil)
			case .failure(let model, let error):
				print("error")
				self.showResponseError(responseModel: model as? BaseResponseModel, apiGenericError: error)
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
		
		if Validations.isValidPassword(testStr: passwordTextField.text!) {
			passwordTextField.errorMessage = ""
		} else {
			passwordTextField.errorMessage = "The password is invalid"
			isValid = false
		}
		
		return isValid
	}
}

