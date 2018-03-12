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
	
	@IBOutlet weak var phoneTextField: ProfileTextField!  {
		didSet {
			phoneTextField.bind { self.viewModelCast.phone = $0 }
		}
	}
	@IBOutlet weak var emailTextField: ProfileTextField! {
		didSet {
			emailTextField.bind { self.viewModelCast.email = $0 }
		}
	}
	@IBOutlet weak var changePasswordButton: UIButton!
	
	@IBOutlet weak var contactDetailsSectionLabel: BoldLabel!
	@IBOutlet weak var address1TextField: ProfileTextField!  {
		didSet {
			address1TextField.bind { self.viewModelCast.addressLine1 = $0 }
		}
	}
	@IBOutlet weak var address2TextField: ProfileTextField!  {
		didSet {
			address2TextField.bind { self.viewModelCast.addressLine2 = $0 }
		}
	}
	@IBOutlet weak var townTextField: ProfileTextField!  {
		didSet {
			townTextField.bind { self.viewModelCast.town = $0 }
		}
	}
	@IBOutlet weak var postcodeTextField: ProfileTextField!  {
		didSet {
			postcodeTextField.bind { self.viewModelCast.postcode = $0 }
		}
	}
	
	@IBOutlet weak var gpInformationSectionLabel: BoldLabel!
	@IBOutlet weak var gpNameTextField: ProfileTextField!  {
		didSet {
			gpNameTextField.bind { self.viewModelCast.gpName = $0 }
		}
	}
	@IBOutlet weak var gpAccessCodeTextField: ProfileTextField!  {
		didSet {
			gpAccessCodeTextField.bind { self.viewModelCast.gpAccessCode = $0 }
		}
	}
	
	@IBOutlet weak var gpAddressLineTextField: ProfileTextField!  {
		didSet {
			gpAddressLineTextField.bind { self.viewModelCast.gpAddressLine = $0 }
		}
	}
	
	@IBOutlet weak var gpPostcodeTextField: ProfileTextField!  {
		didSet {
			gpPostcodeTextField.bind { self.viewModelCast.gpPostcode = $0 }
		}
	}
	@IBOutlet weak var permisionTitleLabel: UILabel!
	@IBOutlet weak var permisionSwitch: UISwitch!
	@IBOutlet weak var permisionDetailsLabel: UILabel!
	
	var viewModelCast: ProfileViewModel!
	
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
		
		registerForKeyboardReturnKey([dobTextField,
									  phoneTextField,
									  emailTextField,
									  address1TextField,
									  address2TextField,
									  townTextField,
									  postcodeTextField,
									  gpNameTextField,
									  gpAccessCodeTextField,
									  gpAddressLineTextField,
									  gpPostcodeTextField])
		
		initViewModel(viewModel: ProfileViewModel())
		refreshFields()
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! ProfileViewModel)
		
		viewModelCast.dobUpdated = { [weak self] (date) in
			DispatchQueue.main.async {
				self?.dobTextField.text = date
			}
		}
		
		viewModelCast.emailValidationStatus = { [weak self] () in
			DispatchQueue.main.async {
				self?.emailTextField.errorMessage = self?.viewModelCast.emailErrorMessage
				self?.emailTextField.becomeFirstResponder()
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		viewModelCast.saveModel()
	}
	
	func showDatePicker() {
		//Formate Date
		datePicker.datePickerMode = .date
		
		//ToolBar
		let toolbar = UIToolbar()
		toolbar.sizeToFit()
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
		let setButton = UIBarButtonItem(title: "Set", style: .plain, target: self, action: #selector(dobPicker))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		
		toolbar.setItems([cancelButton, spaceButton, setButton], animated: false)
		
		dobTextField.inputAccessoryView = toolbar
		dobTextField.inputView = datePicker
	}
	
	@objc func dobPicker() {
		viewModelCast.dob = datePicker.date
		view.endEditing(true)
	}
	
	@objc func cancelDatePicker() {
		view.endEditing(true)
	}
	
	func refreshFields() {
		dobTextField.text = viewModelCast.dobDisplayText
		phoneTextField.text = viewModelCast.phone
		emailTextField.text = viewModelCast.email
		address1TextField.text = viewModelCast.addressLine1
		address2TextField.text = viewModelCast.addressLine2
		townTextField.text = viewModelCast.town
		postcodeTextField.text = viewModelCast.postcode
		gpNameTextField.text = viewModelCast.gpName
		gpAccessCodeTextField.text = viewModelCast.gpAccessCode
		gpAddressLineTextField.text = viewModelCast.gpAddressLine
		gpPostcodeTextField.text = viewModelCast.gpPostcode
		permisionSwitch.isOn = viewModelCast.isPermisionEnabled
	}
	
	@IBAction func onChangePasswordButton(_ sender: Any) {
	}
	
	@IBAction func onPermissionValueChanged(_ sender: Any) {
		viewModelCast.isPermisionEnabled = permisionSwitch.isOn
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
