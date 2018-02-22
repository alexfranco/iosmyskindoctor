//
//  BaseViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {
	
	var updateLoadingStatus: (()->())?
	var showAlert: ((_ title: String, _ message: String) -> ())?
	var showResponseErrorAlert: ((_ responseModel: BaseResponseModel?, _ apiGenericError: ApiUtils.ApiGenericError)  -> ())?
	var goNextSegue: (()->())?
	
	var isLoading: Bool = false {
		didSet {
			self.updateLoadingStatus?()
		}
	}
	
	func validateForm() -> Bool {
		return true
	}
}


