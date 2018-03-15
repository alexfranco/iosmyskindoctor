//
//  SetupWizard1ViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class SetupWizard1ViewModel: BaseViewModel {
	
	var firstName = ""
	var lastName = ""
	
	var dob: Date {
		didSet {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yyyy"
			dobUpdated!(formatter.string(from: dob))
		}
	}
	
	var dobUpdated: ((_ date: String)->())?
	
	var phone = ""
	var postcode = ""
	
	override func validateForm() -> Bool {
		var isValid = true
		
		return isValid
	}
	
	override init() {
		dob = Date()
		super.init()
	}
	
	func saveModel() {
		if !self.validateForm() {
			return
		}
		
		let profile = DataController.createUniqueEntity(type: Profile.self)
		profile.firstName = firstName
		profile.lastName = lastName
		profile.dob = dob as NSDate
		profile.phone = phone
		profile.postcode = postcode
		DataController.saveEntity(managedObject: profile)
		
		goNextSegue!()
	}
}
