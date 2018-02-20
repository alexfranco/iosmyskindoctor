//
//  CustomErrors.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 20/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

struct CustomErrors {
	
	static let domain = "MSDError"
	static let serverCode = -1001
	
	static func getErrorKey(_ code: Int) -> String {
		return String(format: "%d", code)
	}
	
	static func getErrorLocalizedDescription(_ code: Int) -> String {
		return NSLocalizedString(CustomErrors.getErrorKey(code), tableName: "MSDError", bundle: Bundle.main, value: "", comment: CustomErrors.getErrorKey(code))
	}
	
	static func getError(_ code: Int) -> NSError {
		let dictionary: [AnyHashable: Any] = [
			NSLocalizedDescriptionKey : getErrorLocalizedDescription(code)
		]
		
		let error: NSError = NSError.init(domain: domain, code: code, userInfo: dictionary as? [String : Any])
		return error
	}
	
	static func getServerError(_ message: String) -> NSError {
		let dictionary: [AnyHashable: Any] = [
			NSLocalizedDescriptionKey: message
		]
		
		let error: NSError = NSError.init(domain: domain, code: serverCode, userInfo: dictionary as? [String : Any])
		return error
	}
}
