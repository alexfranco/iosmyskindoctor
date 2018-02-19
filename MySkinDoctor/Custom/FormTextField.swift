//
//  FormTextField.swift
//  MySkinDoctor
//
//  Created by Alex on 19/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import TextFieldEffects

class FormTextField: AkiraTextField {
	
	private var originalPlaceholder: String?
	
	private var _placeholder: String?
	override var placeholder: String? {
		didSet {
			_placeholder = placeholder
			
			if originalPlaceholder != nil {
				originalPlaceholder = _placeholder
			}
		}
	}
	
	private var _placeholderColor: UIColor = .black
	override var placeholderColor: UIColor {
		didSet {
			_placeholderColor = placeholderColor
		}
	}
	
	var errorMessage: String? {
		didSet {
			if let errorMessage = errorMessage, !errorMessage.isEmpty {
				let _placeholder = placeholder
				placeholder = errorMessage
				self._placeholder = _placeholder
				
				let _placeholderColor = placeholderColor
				placeholderColor = UIColor.red
				self._placeholderColor = _placeholderColor
			} else {
				placeholderColor = _placeholderColor
				placeholder = originalPlaceholder
			}
		}
	}
}

