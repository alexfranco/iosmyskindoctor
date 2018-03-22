//
//  FormTextField.swift
//  MySkinDoctor
//
//  Created by Alex on 19/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import TextFieldEffects

class FormTextField: DTTextField {
	
	override func awakeFromNib() {
		super.awakeFromNib()
			
		textColor = BaseColors.black
		lblError.textColor = BaseColors.blush
		placeholderColor = BaseColors.blush
		floatPlaceholderActiveColor = BaseColors.skyBlue
		floatPlaceholderColor = BaseColors.warmGrey
		hideErrorWhenEditing = true
	}
	
	// MARK: Binding
	
	var textChanged: (String) -> () = { _ in }
	
	func bind(callback :@escaping (String) -> ()) {
		self.textChanged = callback
		self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
	}
	
	@objc func textFieldDidChange(_ textField :UITextField) {		
		self.textChanged(textField.text!)
		
		self.errorMessage = ""
	}	
}

