//
//  ProfileViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel: BaseViewModel {
	
	var profile: Profile!
	
	var email = ""
	
	var emailValidationStatus: (()->())?
	
	var emailErrorMessage: String = "" {
		didSet {
			self.emailValidationStatus?()
		}
	}
	
	var phone = ""
	
	var dob: Date? {
		didSet {
			dobUpdated!(dobDisplayText)
		}
	}
	
	var dobUpdated: ((_ date: String)->())?

	var dobDisplayText: String {
		if dob == nil {
			return ""
		} else {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yyyy"
			return formatter.string(from: dob!)
		}
	}
	
	var addressLine1 = ""
	var addressLine2 = ""
	var town = ""
	var postcode = ""
	var gpName = ""
	var gpAccessCode = ""
	var gpAddressLine = ""
	var gpPostcode = ""
	var isPermisionEnabled = true
	
	var profileImage: UIImage = UIImage(named: "logo")! {
		didSet {
			profileImageUpdated!(profileImage)
		}
	}
	
	var profileImageUpdated: ((_ image: UIImage)->())?
	

	override func validateForm() -> Bool {
		var isValid = true
		
//		if Validations.isValidEmail(testStr: email) {
//			emailErrorMessage = ""
//		} else {
//			emailErrorMessage = NSLocalizedString("error_email_not_valid", comment: "")
//			isValid = false
//		}
		
		return isValid
	}
	
	override init() {
		super.init()
		
		profile = DataController.createUniqueEntity(type: Profile.self)
		
		email = profile.email ?? ""
		phone = profile.phone ?? ""
		
		if let dobSafe = profile.dob {
			dob = dobSafe as Date
		}
		
		addressLine1 = profile.addressLine1 ?? ""
		addressLine2 = profile.addressLine2 ?? ""
		town = profile.town ?? ""
		postcode = profile.postcode ?? ""
		gpName = profile.gpName ?? ""
		gpAccessCode = profile.gpAccessCode ?? ""
		gpAddressLine = profile.gpAddressLine ?? ""
		gpPostcode = profile.gpPostcode ?? ""
		isPermisionEnabled = profile.isPermisionEnabled
		
		if let profileImageSafe = profile.profileImage as? UIImage {
			profileImage = profileImageSafe
		} else {
			profileImage = UIImage(named: "logo")!
		}
	}
	
	func saveModel() {
		
		if !self.validateForm() {
			return
		}
		
		profile.email = email
		profile.phone = phone
		
		if let dobSafe = dob as NSDate? {
			profile.dob = dobSafe
		}
		
		profile.addressLine1 = addressLine1
		profile.addressLine2 = addressLine2
		profile.town = town
		profile.postcode = postcode
		profile.gpName = gpName
		profile.gpAccessCode = gpAccessCode
		profile.gpAddressLine = gpAddressLine
		profile.gpPostcode = gpPostcode
		profile.isPermisionEnabled = isPermisionEnabled
		profile.profileImage = profileImage
		
		DataController.saveEntity(managedObject: profile)
	}
}
