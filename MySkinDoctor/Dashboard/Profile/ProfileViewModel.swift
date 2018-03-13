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
		
		let profile = DataController.createUniqueObject(type: Profile.self)
		
		if let profileSafe = profile {
			email = profileSafe.email ?? ""
			phone = profileSafe.phone ?? ""
			
			if let dobSafe = profileSafe.dob {
				dob = dobSafe as Date
			}
			
			addressLine1 = profileSafe.addressLine1 ?? ""
			addressLine2 = profileSafe.addressLine2 ?? ""
			town = profileSafe.town ?? ""
			postcode = profileSafe.postcode ?? ""
			gpName = profileSafe.gpName ?? ""
			gpAccessCode = profileSafe.gpAccessCode ?? ""
			gpAddressLine = profileSafe.gpAddressLine ?? ""
			gpPostcode = profileSafe.gpPostcode ?? ""
			isPermisionEnabled = profileSafe.isPermisionEnabled
			
			if let profileImageSafe = profileSafe.profileImage as? UIImage {
				profileImage = profileImageSafe
			} else {
				profileImage = UIImage(named: "logo")!
			}
		}
	}
	
	func saveModel() {
		
		if !self.validateForm() {
			return
		}
		
		let profile = DataController.createUniqueObject(type: Profile.self)
		
		if let profileSafe = profile {
			profileSafe.email = email
			profileSafe.phone = phone
			
			if let dobSafe = dob as NSDate? {
				profileSafe.dob = dobSafe
			}
			
			profileSafe.addressLine1 = addressLine1
			profileSafe.addressLine2 = addressLine2
			profileSafe.town = town
			profileSafe.postcode = postcode
			profileSafe.gpName = gpName
			profileSafe.gpAccessCode = gpAccessCode
			profileSafe.gpAddressLine = gpAddressLine
			profileSafe.gpPostcode = gpPostcode
			profileSafe.isPermisionEnabled = isPermisionEnabled
			profileSafe.profileImage = profileImage
			
			CoreDataStack.saveContext()
		}
		
	}
}
