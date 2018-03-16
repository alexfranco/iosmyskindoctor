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
		
		goNextSegue!()
	}
}
