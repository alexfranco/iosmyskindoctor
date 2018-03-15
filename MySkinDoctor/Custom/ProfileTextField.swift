//
//  ProfileTextField.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

class ProfileTextField: HoshiTextField {
	
	private var originalPlaceholder: String?
	
	private var _placeholder: String?
	override var placeholder: String? {
		didSet {
			_placeholder = placeholder
			
			if originalPlaceholder == nil {
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
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		addLeftPadding()
		borderActiveColor = AppStyle.formTextFieldBorderActiveColor
		borderInactiveColor = AppStyle.formTextFieldBorderInactiveColor
	}
	
	
	// MARK: Binding
	
	var textChanged :(String) -> () = { _ in }
	
	func bind(callback :@escaping (String) -> ()) {
		
		self.textChanged = callback
		self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
	}
	
	@objc func textFieldDidChange(_ textField :UITextField) {
		self.textChanged(textField.text!)
	}
}

