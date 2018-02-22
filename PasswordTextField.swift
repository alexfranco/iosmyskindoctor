//
//  PasswordTextField.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class PasswordTextField: FormTextField {
	
	//KVO Context
	fileprivate var kvoContext: UInt8 = 0
	
	var secureTextButton: UIButton?
	var showPasswordImage = UIImage(named: "passwordVisibleIcon")
	var hidePasswordImage = UIImage(named: "passwordNotVisibleIcon")
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	/**
	Initialize properties and values
	*/
	func setup() {
		self.isSecureTextEntry = true
		self.autocapitalizationType = .none
		self.autocorrectionType = .no
		self.keyboardType = .asciiCapable
		
		setRightViewIcon(icon: showPasswordImage!)
	}
	
	func setRightViewIcon(icon: UIImage) {
		let padding = CGFloat(3)
		
		secureTextButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.height * 0.70, height: self.frame.height * 0.70))
		secureTextButton?.setImage(icon, for: .normal)
		secureTextButton?.imageEdgeInsets = UIEdgeInsets(top: padding * 2, left: padding, bottom: 0, right: padding)
		secureTextButton?.addTarget(self, action: #selector(toggleShowPassword(_:)), for: UIControlEvents.touchUpInside)
		self.rightViewMode = .always
		self.rightView = secureTextButton
	}
	
	@objc func toggleShowPassword(_ sender: Any) {
		self.setSecureMode(!self.isSecureTextEntry)
	}
	
	/**
	Toggle the secure text view or not
	*/
	open func setSecureMode(_ secure:Bool) {
		self.isSecureTextEntry = secure
		self.secureTextButton?.setImage(secure ? showPasswordImage : hidePasswordImage, for: UIControlState.normal)
	}
	
}

