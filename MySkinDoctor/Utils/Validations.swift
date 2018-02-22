//
//  Validations.swift
//  MySkinDoctor
//
//  Created by Alex on 19/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class Validations {
	
	static func isValidEmail(testStr:String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: testStr)
	}

	static func isValidPassword(testStr: String) -> Bool {
		let validType = PasswordStrength.checkPasswordStrength(testStr)
		return validType != PasswordStrengthType.noValidLength && validType != PasswordStrengthType.empty
	}
}
