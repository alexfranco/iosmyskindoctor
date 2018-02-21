//
//  LoginViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 14/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import TextFieldEffects
import UIKit

class LoginViewController: FormViewController {
	
	@IBOutlet weak var logoImageView: UIImageView!
	@IBOutlet weak var emailTextField: FormTextField! {
		didSet {
			emailTextField.bind { self.viewModel.email = $0 }
		}
	}
	
	@IBOutlet weak var passwordTextField: FormTextField! {
		didSet {
			passwordTextField.bind { self.viewModel.password = $0 }
		}
	}
	
	var viewModel = LoginViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.placeholder = "Email"
		passwordTextField.placeholder = "Password"

		registerForKeyboardReturnKey([emailTextField, passwordTextField])
		
		initVM()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Hide the navigation bar on the this view controller
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	// MARK: Bindings
	
	func initVM() {
		viewModel.showAlert = { [weak self] (title, message) in
			DispatchQueue.main.async {
				self?.showAlertView(title: title, message: message)
			}
		}
		
		viewModel.showResponseErrorAlert = { [weak self] (baseResponseModel, apiGenericError) in
			DispatchQueue.main.async {
				self?.showResponseError(responseModel: baseResponseModel, apiGenericError: apiGenericError)
			}
		}
		
		viewModel.updateLoadingStatus = { [weak self] () in
			DispatchQueue.main.async {
				let isLoading = self?.viewModel.isLoading ?? false
				if isLoading {
					self?.showSpinner("")
					self?.nextButton.isEnabled = false
				} else {
					self?.hideSpinner()
					self?.nextButton.isEnabled = true
				}
			}
		}
		
		viewModel.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToMainStoryboardFromLogin, sender: nil)
			}
		}
		
		viewModel.emailValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.emailTextField.errorMessage = self?.viewModel.emailErrorMessage
			}
		}
		
		viewModel.passwordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.passwordTextField.errorMessage = self?.viewModel.passwordErrorMessage
			}
		}

	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModel.loginUser()
	}
	
	// MARK: Unwind
	
	@IBAction func unwindToLogin(segue:UIStoryboardSegue) {
	}
}
