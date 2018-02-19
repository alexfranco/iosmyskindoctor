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
	@IBOutlet weak var emailTextField: AkiraTextField!
	@IBOutlet weak var passwordTextField: AkiraTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerForKeyboardReturnKey([emailTextField, passwordTextField])
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		showSpinner(nil)
		
		ApiUtils.login(email: emailTextField.text!, password: passwordTextField.text!) { (result) in
			self.hideSpinner()
			
			switch result {
			case .success(let model):
				print("login success")
			case .failure(let model, let error):
				print("error")
				self.showResponseError(responseModel: model as? BaseResponseModel, apiGenericError: error)
			}
		}
	}
}
