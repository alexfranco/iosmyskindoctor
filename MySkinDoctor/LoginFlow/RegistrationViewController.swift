//
//  RegistrationViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 14/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import TextFieldEffects
import UIKit

class RegistrationViewController: FormViewController {
	
	@IBOutlet weak var logoImageView: UIImageView!
	@IBOutlet weak var emailTextField: FormTextField! {
		didSet {
			emailTextField.bind { self.viewModelCast.email = $0 }
		}
	}
	
	@IBOutlet weak var passwordTextField: PasswordTextField! {
		didSet {
			passwordTextField.bind { self.viewModelCast.password = $0 }
		}
	}
	
	var viewModelCast: RegistrationViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.placeholder = NSLocalizedString("email", comment: "")
		passwordTextField.placeholder = NSLocalizedString("password", comment: "")
		
		registerForKeyboardReturnKey([emailTextField, passwordTextField])
		
		initViewModel(viewModel: RegistrationViewModel())
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Hide the navigation bar on the this view controller
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! RegistrationViewModel
		
		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
			
				self?.showAlertView(title: NSLocalizedString("registration_success_title", comment: ""), message: NSLocalizedString("registration_success_message", comment: ""), handler: { (action) in
					self?.navigationController?.popViewController(animated: true)
				})
			}
		}
		
		viewModelCast.emailValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.emailTextField.showError(message: self?.viewModelCast.emailErrorMessage)
				self?.emailTextField.becomeFirstResponder()
			}
		}
		
		viewModelCast.passwordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.passwordTextField.showError(message: self?.viewModelCast.passwordErrorMessage)
				self?.passwordTextField.becomeFirstResponder()
			}
		}
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		self.viewModelCast.registerUser()
	}
}

