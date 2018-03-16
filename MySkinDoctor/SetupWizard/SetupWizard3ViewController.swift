//
//  SetupWizard3ViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SetupWizard3ViewController: FormViewController {
	
	@IBOutlet weak var gpNameTextField: FormTextField! {
		didSet {
			gpNameTextField.bind { self.viewModelCast.gpName = $0 }
		}
	}
	@IBOutlet weak var gpAccessCodeTextField: FormTextField! {
		didSet {
			gpAccessCodeTextField.bind { self.viewModelCast.gpAccessCode = $0 }
		}
	}
	
	@IBOutlet weak var gpAddressLineTextField: FormTextField! {
		didSet {
			gpAddressLineTextField.bind { self.viewModelCast.gpAddressLine = $0 }
		}
	}
	
	@IBOutlet weak var gpPostcodeTextField: FormTextField!  {
		didSet {
			gpPostcodeTextField.bind { self.viewModelCast.gpPostCode = $0 }
		}
	}
	
	@IBOutlet weak var permisionTitleLabel: UILabel!
	@IBOutlet weak var permisionDetailLabel: UILabel!
	
	@IBOutlet weak var permisionSwitch: UISwitch!
	
	var viewModelCast: SetupWizard3ViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Setup Wizard 3"
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		registerForKeyboardReturnKey([gpNameTextField,
									  gpAccessCodeTextField,
									  gpAddressLineTextField,
									  gpPostcodeTextField])
		
		initViewModel(viewModel: SetupWizard3ViewModel())
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! SetupWizard3ViewModel)
		viewModelCast.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.dismiss(animated: true, completion: nil)
			}
		}
	}
	
	@IBAction func onPermissionValueChanged(_ sender: Any) {
		viewModelCast.isPermisionEnabled = permisionSwitch.isOn
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
}
