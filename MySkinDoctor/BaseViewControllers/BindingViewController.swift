//
//  BindingViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class BindingViewController: ProgressBarViewController {
	
	@IBOutlet weak var nextButton: UIButton!
	var viewModel: BaseViewModel?

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
				if apiGenericError == ApiUtils.ApiGenericError.authorizatioError {
					DataController.logout()
				} else {
					self?.showResponseError(responseModel: baseResponseModel, apiGenericError: apiGenericError)
				}
			}
		}
		
		viewModelSafe.updateLoadingStatus = { [weak self] () in
			DispatchQueue.main.async {
				let isLoading = viewModelSafe.isLoading
				if isLoading {
					self?.showSpinner("")
					
					if self?.nextButton != nil {
						self?.nextButton.isEnabled = false
					}
				} else {
					self?.hideSpinner()
					
					if self?.nextButton != nil {
						self?.nextButton.isEnabled = true
					}
				}
			}
		}
	}
}

