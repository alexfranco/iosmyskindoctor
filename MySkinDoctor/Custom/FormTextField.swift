//
//  FormTextField.swift
//  MySkinDoctor
//
//  Created by Alex on 19/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import TextFieldEffects
import LRTextField

class FormTextField: LRTextField {
	
	private var originalPlaceholderActiveColor = BaseColors.warmGrey
	private var originalPlaceholderInactiveColor = BaseColors.formGrey
	private var originalTextFieldBorder = BaseColors.formGrey
	private var errorColor = BaseColors.blush
	
	var hasErrors: Bool = false {
		didSet {
			if hasErrors {
				layer.borderColor = errorColor.cgColor
				placeholderActiveColor = errorColor
				placeholderInactiveColor = errorColor
			} else {
				// default colours
				layer.borderColor = originalTextFieldBorder.cgColor
				placeholderActiveColor = originalPlaceholderActiveColor
				placeholderInactiveColor = originalPlaceholderInactiveColor
			}
		}
	}
	
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
	
	var errorMessage: String? {
		didSet {
			if let errorMessage = errorMessage, !errorMessage.isEmpty {
				self.placeholder = errorMessage
				hasErrors = true
				
			} else {
				self.placeholder = originalPlaceholder
				hasErrors = false
			}
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()

		textColor = BaseColors.warmGrey
		borderStyle = UITextBorderStyle.roundedRect
		layer.borderWidth = 1
		layer.borderColor = originalTextFieldBorder.cgColor
		
		floatingLabelHeight = 12
		placeholderActiveColor = originalPlaceholderActiveColor
		placeholderInactiveColor = originalPlaceholderInactiveColor
	}
	
	// MARK: Binding
	
	var textChanged :(String) -> () = { _ in }
	
	func bind(callback :@escaping (String) -> ()) {
		
		self.textChanged = callback
		self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
	}
	
	@objc func textFieldDidChange(_ textField :UITextField) {		
		self.textChanged(textField.text!)
		
		self.errorMessage = ""
	}	
}

