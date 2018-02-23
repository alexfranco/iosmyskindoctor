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
			emailTextField.bind { (self.viewModel as! RegistrationViewModel).email = $0 }
		}
	}
	
	@IBOutlet weak var passwordTextField: PasswordTextField! {
		didSet {
			passwordTextField.bind { (self.viewModel as! RegistrationViewModel).password = $0 }
		}
	}
	
	
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
		
		let registrationViewModel = viewModel as! RegistrationViewModel
		
		registrationViewModel.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToMainStoryboardFromLogin, sender: nil)
			}
		}
		
		registrationViewModel.emailValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.emailTextField.errorMessage = registrationViewModel.emailErrorMessage
				self?.emailTextField.becomeFirstResponder()
			}
		}
		
		registrationViewModel.passwordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.passwordTextField.errorMessage = registrationViewModel.passwordErrorMessage
				self?.passwordTextField.becomeFirstResponder()
			}
		}
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		(viewModel as! RegistrationViewModel).registerUser()
	}
}

