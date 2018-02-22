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
	@IBOutlet weak var emailTextField: FormTextField! {
		didSet {
			emailTextField.bind { (self.viewModel as! ForgotPasswordViewModel).email = $0 }
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.placeholder = "Email"
		registerForKeyboardReturnKey([emailTextField])
	
		initViewModel(viewModel: ForgotPasswordViewModel())
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Hide the navigation bar on the this view controller
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		let forgotPasswordViewModel = viewModel as! ForgotPasswordViewModel
		
		forgotPasswordViewModel.goNextSegue = { [] () in
			DispatchQueue.main.async {
				let title = NSLocalizedString("reset_password_success_title", comment: "Reset password")
				let message = NSLocalizedString("reset_password_success_message", comment: "Reset password successful")
				
				self.showAlertView(title: title, message: message) { (action) in
					self.navigationController?.popViewController(animated: true)
				}
			}
		}
		
		forgotPasswordViewModel.emailValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.emailTextField.errorMessage = forgotPasswordViewModel.emailErrorMessage
				self?.emailTextField.becomeFirstResponder()
			}
		}
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		(viewModel as! ForgotPasswordViewModel).requestPassword()
	}
	
	// MARK: Unwind
	
	@IBAction func unwindToLogin(segue:UIStoryboardSegue) {
	}
}
