//
//  ChangePasswordViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 16/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordViewController: FormViewController {
	
	@IBOutlet weak var oldPasswordTextField: PasswordTextField!  {
		didSet {
			oldPasswordTextField.bind { self.viewModelCast.oldPassword = $0 }
		}
	}
	
	@IBOutlet weak var newPasswordTextField: PasswordTextField!  {
		didSet {
			newPasswordTextField.bind { self.viewModelCast.newPassword = $0 }
		}
	}
	
	@IBOutlet weak var confirmNewPasswordTextField: PasswordTextField!  {
		didSet {
			confirmNewPasswordTextField.bind { self.viewModelCast.confirmPassword = $0 }
		}
	}
	
	var viewModelCast: ChangePasswordViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initViewModel(viewModel: ChangePasswordViewModel())
		
		registerForKeyboardReturnKey([oldPasswordTextField, newPasswordTextField, confirmNewPasswordTextField])
		
		oldPasswordTextField.showPasswordBar = false
		
		applyLocalization()
		applytheme()
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! ChangePasswordViewModel)
		
		viewModelCast.oldPasswordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.oldPasswordTextField.errorMessage = self?.viewModelCast.oldPasswordErrorMessage
				self?.oldPasswordTextField.becomeFirstResponder()
			}
		}
		
		viewModelCast.newPasswordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.newPasswordTextField.errorMessage = self?.viewModelCast.newPasswordErrorMessage
				self?.newPasswordTextField.becomeFirstResponder()
			}
		}
		
		viewModelCast.confirmPasswordValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.confirmNewPasswordTextField.errorMessage = self?.viewModelCast.confirmPasswordErrorMessage
				self?.confirmNewPasswordTextField.becomeFirstResponder()
			}
		}
		
		viewModelCast.showResponseErrorAlert = { [weak self] (baseResponseModel, apiGenericError) in
			DispatchQueue.main.async {
				self?.showResponseError(responseModel: baseResponseModel, apiGenericError: apiGenericError)
			}
		}
		
		viewModelCast.didSaveChanges = { [weak self] () in
			DispatchQueue.main.async {
				self?.showAlertView(title: "", message: NSLocalizedString("changes_saved", comment: ""), handler: { (action) in
					self?.dismiss(animated: true, completion: nil)
				})
			}
		}
	}
	
	// MARK: Helpers
	
	func applytheme() {
		nextButton.setTitleColor(AppStyle.changePasswordNextButtonTitleColor, for: .normal)
		nextButton.backgroundColor = AppStyle.changePasswordNextButtonBackgroundColor
	}
	
	func applyLocalization() {
		title = NSLocalizedString("change_password_main_vc_title", comment: "")
		
		oldPasswordTextField.placeholder =  NSLocalizedString("change_password_old_password", comment: "")
		newPasswordTextField.placeholder =  NSLocalizedString("change_password_new_password", comment: "")
		confirmNewPasswordTextField.placeholder =  NSLocalizedString("change_password_confirm_password", comment: "")
		
		nextButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
	}
	
	@IBAction func onSaveButtonPressed(_ sender: Any) {
		viewModelCast.changePassword()
	}
}

