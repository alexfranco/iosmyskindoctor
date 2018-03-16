//
//  SetupWizard1ViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SetupWizard1ViewController: FormViewController {
	
	@IBOutlet weak var firstNameTextField: FormTextField!  {
		didSet {
			firstNameTextField.bind { self.viewModelCast.firstName = $0 }
		}
	}
	@IBOutlet weak var lastNameTextField: FormTextField!  {
		didSet {
			lastNameTextField.bind { self.viewModelCast.lastName = $0 }
		}
	}
	
	@IBOutlet weak var dobTextField: FormTextField!
	
	
	@IBOutlet weak var phoneTextField: FormTextField!  {
		didSet {
			phoneTextField.bind { self.viewModelCast.phone = $0 }
		}
	}
	
	@IBOutlet weak var postcodeTextField: FormTextField!  {
		didSet {
			postcodeTextField.bind { self.viewModelCast.postcode = $0 }
		}
	}
	
	@IBOutlet weak var personalDetailsTitleLabel: UILabel!
	@IBOutlet weak var neverShareLabel: UILabel!
	
	var viewModelCast: SetupWizard1ViewModel!
	
	let datePicker = UIDatePicker()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Setup Wizard 1"
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		registerForKeyboardReturnKey([firstNameTextField,
									  lastNameTextField,
									  dobTextField,
									  phoneTextField,
									  postcodeTextField,
									  ])
		
		initViewModel(viewModel: SetupWizard1ViewModel())
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! SetupWizard1ViewModel)
		
		viewModelCast.dobUpdated = { [weak self] (date) in
			DispatchQueue.main.async {
				self?.dobTextField.text = date
			}
		}
		viewModelCast.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToSetupWizard2, sender: nil)
			}
		}
	}
	
	func showDatePicker() {
		//Formate Date
		datePicker.datePickerMode = .date
		
		//ToolBar
		let toolbar = UIToolbar()
		toolbar.sizeToFit()
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
		let setButton = UIBarButtonItem(title: "Set", style: .plain, target: self, action: #selector(dobPicker))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		
		toolbar.setItems([cancelButton, spaceButton, setButton], animated: false)
		
		dobTextField.inputAccessoryView = toolbar
		dobTextField.inputView = datePicker
	}
	
	@objc func dobPicker() {
		viewModelCast.dob = datePicker.date
		view.endEditing(true)
	}
	
	@objc func cancelDatePicker() {
		view.endEditing(true)
	}
	
	// MARK: UITextFieldDelegate
	
	override func textFieldDidBeginEditing(_ textField: UITextField) {
		super.textFieldDidBeginEditing(textField)
		
		if textField == dobTextField {
			showDatePicker()
		}
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
}


