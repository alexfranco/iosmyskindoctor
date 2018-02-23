//
//  PasswordStrength.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

private let minimunPasswordLength: Int = 8
private let maximunPasswordLength: Int = 25

let REGEX_PASSWORD_ONE_UPPERCASE = "^(?=.*[A-Z]).*$"
let REGEX_PASSWORD_ONE_LOWERCASE = "^(?=.*[a-z]).*$"
let REGEX_PASSWORD_ONE_NUMBER = "^(?=.*[0-9]).*$"
let REGEX_PASSWORD_ONE_SYMBOL = "^(?=.*[!@#$%&_]).*$"

enum PasswordStrengthType : Int {
	case empty
	case noValidLength
	case weak
	case moderate
	case strong
}

class PasswordStrength {
	
	static func checkPasswordStrength(_ password: String) -> PasswordStrengthType {
		// if the string is empty we don't check anything we just return that the password is empty
		if password.isEmpty {
			return PasswordStrengthType.empty
		}
		// String minimun length
		if !(password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count >= minimunPasswordLength) {
			return PasswordStrengthType.noValidLength
		}
		// String maximum length
		if !(password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count <= maximunPasswordLength) {
			return PasswordStrengthType.noValidLength
		}
		let len: Int = password.count
		//will contains password strength
		var strength: Int = 0
		if len == 0 {
			return PasswordStrengthType.weak
		}
		else if len <= 5 {
			strength += 1
		}
		else if len <= 10 {
			strength += 2
		}
		else {
			strength += 3
		}
		strength += self.validate(password, withPattern: REGEX_PASSWORD_ONE_UPPERCASE)
		strength += self.validate(password, withPattern: REGEX_PASSWORD_ONE_LOWERCASE)
		strength += self.validate(password, withPattern: REGEX_PASSWORD_ONE_NUMBER)
		strength += self.validate(password, withPattern: REGEX_PASSWORD_ONE_SYMBOL)
		if strength <= 3 {
			return PasswordStrengthType.weak
		}
		else if 3 < strength && strength < 6 {
			return PasswordStrengthType.moderate
		}
		else {
			return PasswordStrengthType.strong
		}
	}
	
	// MARK: - Private
	// Validate the input string with the given pattern and
	// return the result as a boolean
	static func validate(_ string: String, withPattern pattern: String) -> Int {
		let  regex = try? NSRegularExpression(pattern: pattern)
		assert(regex != nil, "Unable to create regular expression")
		let textRange = NSRange(location: 0, length: string.count)
		let matchRange: NSRange? = regex?.rangeOfFirstMatch(in: string, options: .reportProgress, range: textRange)
		var didValidate = false
		// Did we find a matching range
		if matchRange?.location != NSNotFound {
			didValidate = true
		}
		return didValidate ? 1 : 0
	}
	
}

