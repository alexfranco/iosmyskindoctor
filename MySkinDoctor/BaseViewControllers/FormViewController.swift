//
//  FormViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import BSKeyboardControls

class FormViewController: ProgressBarViewController, UITextFieldDelegate, BSKeyboardControlsDelegate {
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var nextButton: UIButton!
	var viewModel: BaseViewModel?
	
	var fields: [UITextField] = []
	var keyboardControls: BSKeyboardControls? // Here's our property
	
	func registerForKeyboardReturnKey(_ fields: [UITextField]) {
		// Set up keyboard return button
		self.fields = fields
		for i in 0 ..< self.fields.count {
			let field = self.fields[i]
			field.delegate = self
			field.tag = i
			field.returnKeyType = UIReturnKeyType.next
			
			if i == self.fields.count - 1 {
				field.returnKeyType = UIReturnKeyType.done
			}
		}
		
		keyboardControls = BSKeyboardControls(fields: fields)
		keyboardControls?.delegate = self
	}
	
	
	// MARK: Bindings
	
	func initViewModel(viewModel: BaseViewModel) {
		self.viewModel = viewModel
		
		guard let viewModelSafe = self.viewModel else {
			return
		}
		viewModelSafe.showAlert = { [weak self] (title, message) in
			DispatchQueue.main.async {
				self?.showAlertView(title: title, message: message)
			}
		}
		
		viewModelSafe.showResponseErrorAlert = { [weak self] (baseResponseModel, apiGenericError) in
			DispatchQueue.main.async {
				self?.showResponseError(responseModel: baseResponseModel, apiGenericError: apiGenericError)
			}
		}
		
		viewModelSafe.updateLoadingStatus = { [weak self] () in
			DispatchQueue.main.async {
				let isLoading = viewModelSafe.isLoading
				if isLoading {
					self?.showSpinner("")
					self?.nextButton.isEnabled = false
				} else {
					self?.hideSpinner()
					self?.nextButton.isEnabled = true
				}
			}
		}
	}
	
	// MARK: UITextFieldDelegate
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if keyboardControls != nil {
			keyboardControls?.activeField = textField
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == fields.last {
			self.view.endEditing(true)
		} else {
			keyboardControls?.activeField = fields[fields.index(after: textField.tag)]
		}
		
		return true
	}
	
	// MARK: Actions
	
	func keyboardControlsDonePressed(_ keyboardControls: BSKeyboardControls!) {
		keyboardControls.activeField.resignFirstResponder()
	}	
}
