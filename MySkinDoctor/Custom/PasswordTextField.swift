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
	
	var showPasswordBar = true {
		didSet {
			passwordProgressBarView?.isHidden = !showPasswordBar
		}
	}
	
	var secureTextButton: UIButton?
	var passwordProgressBarView: PasswordProgressBarView?
	var showPasswordImage = UIImage(named: "passwordVisibleIcon")
	var hidePasswordImage = UIImage(named: "passwordNotVisibleIcon")
	
	var getPasswordStrength: PasswordStrengthType {
		get {
			return PasswordStrength.checkPasswordStrength(self.text!)
		}
	}
	
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
		isSecureTextEntry = true
		clearsOnBeginEditing = true
		autocapitalizationType = .none
		autocorrectionType = .no
		keyboardType = .asciiCapable
		
		setRightViewIcon(icon: showPasswordImage!)
		
		addStrengthView()
	}
	
	func addStrengthView() {
		passwordProgressBarView = PasswordProgressBarView()
		
		self.addSubview(passwordProgressBarView!)
		
		self.passwordProgressBarView!.translatesAutoresizingMaskIntoConstraints = false
		let bottomConstraint = NSLayoutConstraint(item: passwordProgressBarView!, attribute: NSLayoutAttribute.bottomMargin, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: (passwordProgressBarView?.frame.height)!)
		
		let leadConstraint = NSLayoutConstraint(item: passwordProgressBarView!, attribute: NSLayoutAttribute.leadingMargin, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leadingMargin, multiplier: 1, constant: 0)
		
		let trailConstraint = NSLayoutConstraint(item: passwordProgressBarView!, attribute: NSLayoutAttribute.trailingMargin, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailingMargin, multiplier: 1, constant: 0)
		
		self.addConstraints([bottomConstraint, leadConstraint, trailConstraint])
	}
	
	func setRightViewIcon(icon: UIImage) {
		let padding = CGFloat(3)
		
		secureTextButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.height * 0.70, height: frame.height * 0.70))
		secureTextButton?.setImage(icon, for: .normal)
		secureTextButton?.imageEdgeInsets = UIEdgeInsets(top: padding * 2, left: padding, bottom: 0, right: padding)
		secureTextButton?.addTarget(self, action: #selector(toggleShowPassword(_:)), for: UIControlEvents.touchUpInside)
		rightViewMode = .always
		rightView = secureTextButton
	}
	
	@objc func toggleShowPassword(_ sender: Any) {
		setSecureMode(!self.isSecureTextEntry)
	}
	
	/**
	Toggle the secure text view or not
	*/
	open func setSecureMode(_ secure:Bool) {
		isSecureTextEntry = secure
		secureTextButton?.setImage(secure ? showPasswordImage : hidePasswordImage, for: UIControlState.normal)
	}
	
	override func textFieldDidChange(_ textField: UITextField) {
		super.textFieldDidChange(textField)
		passwordProgressBarView?.updatePasswordStrength(strength: getPasswordStrength)
	}
}
