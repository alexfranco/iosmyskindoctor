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
	
	@IBOutlet weak var logoutButton: UIButton!
	
	var viewModelCast: ProfileViewModel!
	
	let datePicker = UIDatePicker()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		applyLocalization()
		applytheme()
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! ProfileViewModel)
		
		viewModelCast.profileImageUpdated = { [weak self] (image) in
			DispatchQueue.main.async {
				self?.userPhotoImageView.contentMode = .scaleAspectFill
				self?.userPhotoImageView.image = image
			}
		}
		
		viewModelCast.dobUpdated = { [weak self] (date) in
			DispatchQueue.main.async {
				self?.dobTextField.text = date
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		viewModelCast.saveModel()
	}
	
	// MARK: UITextFieldDelegate
	
	override func textFieldDidBeginEditing(_ textField: UITextField) {
		super.textFieldDidBeginEditing(textField)
		
		if textField == dobTextField {
			showDatePicker()
		}
	}
	
	// MARK: Helpers
	
	func applytheme() {
		changePasswordButton.setTitleColor(AppStyle.changePasswordButtonTitleColor, for: .normal)
		logoutButton.setTitleColor(AppStyle.logoutButtonTitleColor, for: .normal)
	}
	
	func applyLocalization() {
		title = NSLocalizedString("profile_main_vc_title", comment: "")
		
		dobTextField.placeholder = NSLocalizedString("date_of_birth", comment: "")
		phoneTextField.placeholder = NSLocalizedString("mobile_number", comment: "")
		
		address1TextField.placeholder = NSLocalizedString("address_line_1", comment: "")
		address2TextField.placeholder = NSLocalizedString("address_line_2", comment: "")
		townTextField.placeholder = NSLocalizedString("town_city", comment: "")
		postcodeTextField.placeholder = NSLocalizedString("postcode", comment: "")
		
		gpNameTextField.placeholder = NSLocalizedString("gp_name", comment: "")
		gpAccessCodeTextField.placeholder = NSLocalizedString("gp_access_code", comment: "")
		gpAddressLineTextField.placeholder = NSLocalizedString("gp_address_line", comment: "")
		gpPostcodeTextField.placeholder = NSLocalizedString("gp_postcode", comment: "")
		
		// Sections
		personalDetailsSectionLabel.text = NSLocalizedString("profile_personal_details", comment: "")
		contactDetailsSectionLabel.text = NSLocalizedString("profile_personal_contact_details", comment: "")
		gpInformationSectionLabel.text = NSLocalizedString("profile_personal_gp_information", comment: "")
		
		changePasswordButton.setTitle(NSLocalizedString("profile_personal_change_password", comment: ""), for: .normal)
		
			permisionTitleLabel.text = NSLocalizedString("permisions_switch", comment: "")
		
		permisionDetailsLabel.text = NSLocalizedString("permisions_details", comment: "")
		
		logoutButton.setTitle(NSLocalizedString("profile_personal_logout", comment: ""), for: .normal)
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
		userPhotoImageView.image = viewModelCast.profileImage
		nameLabel.text = viewModelCast.name
		emailLabel.text = viewModelCast.email
		
		dobTextField.text = viewModelCast.dobDisplayText
		phoneTextField.text = viewModelCast.phone		
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
	@IBAction func onLogoutPressed(_ sender: Any) {
		DataController.logout()
	}
}

extension ProfileViewController: UIGestureRecognizerDelegate {
	
	@objc func tapUserPhoto(_ sender: UITapGestureRecognizer) {
		let photoUtils = PhotoUtils(inViewController: self)
		photoUtils.showChoosePhoto { (success, image) in
			if success {
				self.viewModelCast.profileImage = image!
			}
		}
	}
}
