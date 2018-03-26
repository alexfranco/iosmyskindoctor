//
//  UIViewController+Alerts.swift
//  MySkinDoctor
//
//  Created by Alex on 19/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	
	func showAlertView(title: String, message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
		let alertController = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert)
	
		let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: "Close button"), style: .default, handler: handler)
	
		alertController.addAction(OKAction)
		self.present(alertController, animated: true) {}
	}
	
	func showResponseError(responseModel: BaseResponseModel?, apiGenericError: ApiUtils.ApiGenericError) {
		if let responseModelSafe = responseModel, let firstError = responseModelSafe.nonFieldErrors.first {
			showAlertView(title: "Error", message: firstError)
		} else {
			switch apiGenericError {
			case .permisionDenied:
				showAlertView(title: "Error", message: "Permission denied.")
			case .parseError:
				showAlertView(title: "Error", message: "There is an error parsing the JSON object from the server.")
			case .httpQueryError:
				showAlertView(title: "Error", message: "There is an error with the HTTP query.")
			case .noErrors: break
				// nothing
			default:
				showAlertView(title: "Error", message: "There is an unknown error")
			}
		}
	}
	
	func showConnectivityError() {
		showAlertView(title: NSLocalizedString("offline_generic_title", comment: "Connectivity error"), message: NSLocalizedString("offline_generic_message", comment: "No internet"))
	}
}
