//
//  ProfileViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: FormViewController {
	
	@IBOutlet weak var profileTopView: UIView!
	@IBOutlet weak var nameLabel: TitleLabel!
	@IBOutlet weak var emailLabel: GrayLabel!
	@IBOutlet weak var userPhotoImageView: UIImageView!
	
	@IBOutlet weak var personalDetailsSectionLabel: BoldLabel!
	@IBOutlet weak var dobTextField: ProfileTextField!
	let datePicker = UIDatePicker()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "My Profile"
		
		profileTopView.backgroundColor = AppStyle.profileTopViewBackgroundColor
		userPhotoImageView?.setRounded()
		userPhotoImageView.setWhiteBorder()
		
		let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserPhoto(_:)))
		imageTapGesture.delegate = self
		userPhotoImageView.addGestureRecognizer(imageTapGesture)
		imageTapGesture.numberOfTapsRequired = 1
		userPhotoImageView.isUserInteractionEnabled = true
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.profileNavigationBarColor, titleColor: AppStyle.profileNavigationBarTitleColor)
		
		registerForKeyboardReturnKey([dobTextField])
		
		initViewModel(viewModel: ProfileViewModel())
	}
	
	func showDatePicker() {
		//Formate Date
		datePicker.datePickerMode = .date
		
		//ToolBar
		let toolbar = UIToolbar();
		toolbar.sizeToFit()
		let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dobPicker));
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
		
		toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
		
		dobTextField.inputAccessoryView = toolbar
		dobTextField.inputView = datePicker
	}
	
	@objc func dobPicker() {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy"
		dobTextField.text = formatter.string(from: datePicker.date)
		self.view.endEditing(true)
	}
	
	@objc func cancelDatePicker() {
		self.view.endEditing(true)
	}
	
	// MARK: UITextFieldDelegate
	
	override func textFieldDidBeginEditing(_ textField: UITextField) {
		super.textFieldDidBeginEditing(textField)
		
		if textField == dobTextField {
			showDatePicker()
		}
	}
}

extension ProfileViewController: UIGestureRecognizerDelegate {
	
	@objc func tapUserPhoto(_ sender: UITapGestureRecognizer) {
		let photoUtils = PhotoUtils(inViewController: self)
		photoUtils.showChoosePhoto { (success, image) in
			self.userPhotoImageView.contentMode = .scaleAspectFill
			self.userPhotoImageView.image = image
		}
	}
}
