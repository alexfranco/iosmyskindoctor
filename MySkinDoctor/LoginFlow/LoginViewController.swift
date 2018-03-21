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
			emailTextField.bind { self.viewModelCast.email = $0 }
		}
	}
	
	@IBOutlet weak var passwordTextField: PasswordTextField! {
		didSet {
			passwordTextField.bind { self.viewModelCast.password = $0 }
		}
	}
	
	var viewModelCast: LoginViewModel!
		
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
		
		viewModelCast = (viewModel as! LoginViewModel)
		
		viewModelCast.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToMainStoryboardFromLogin, sender: nil)
			}
		}
		
		viewModelCast.emailValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.emailTextField.errorMessage = self?.viewModelCast.emailErrorMessage
				self?.emailTextField.becomeFirstResponder()
			}
		}
		
		viewModelCast.passwordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.passwordTextField.errorMessage = self?.viewModelCast.passwordErrorMessage
				self?.passwordTextField.becomeFirstResponder()
			}
		}
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.loginUser()
	}
	
	// MARK: Unwind
	
	@IBAction func unwindToLogin(segue:UIStoryboardSegue) {
	}
}
