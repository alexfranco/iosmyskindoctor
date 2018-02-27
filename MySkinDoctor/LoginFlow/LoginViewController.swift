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
			emailTextField.bind { (self.viewModel as! LoginViewModel).email = $0 }
		}
	}
	
	@IBOutlet weak var passwordTextField: PasswordTextField! {
		didSet {
			passwordTextField.bind { (self.viewModel as! LoginViewModel).password = $0 }
		}
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.placeholder = NSLocalizedString("email", comment: "")
		passwordTextField.placeholder = NSLocalizedString("password", comment: "")
		
		registerForKeyboardReturnKey([emailTextField, passwordTextField])

		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		initViewModel(viewModel: LoginViewModel())
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Hide the navigation bar on the this view controller
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		let loginViewModel = (viewModel as! LoginViewModel)
		
		loginViewModel.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToMainStoryboardFromLogin, sender: nil)
			}
		}
		
		loginViewModel.emailValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.emailTextField.errorMessage = loginViewModel.emailErrorMessage
				self?.emailTextField.becomeFirstResponder()
			}
		}
		
		loginViewModel.passwordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.passwordTextField.errorMessage = loginViewModel.passwordErrorMessage
				self?.passwordTextField.becomeFirstResponder()
			}
		}
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		(self.viewModel as! LoginViewModel).loginUser()
	}
	
	// MARK: Unwind
	
	@IBAction func unwindToLogin(segue:UIStoryboardSegue) {
	}
}
