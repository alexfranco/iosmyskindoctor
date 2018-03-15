//
//  SetupWizard3ViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class SetupWizard3ViewModel: BaseViewModel {
	
	var gpName = ""
	var gpAccessCode = ""
	var gpAddressLine = ""
	var gpPostcode = ""
	var isPermisionEnabled = false
	
	override init() {		
		super.init()
	}
	
	func saveModel() {
		let profile = DataController.createUniqueEntity(type: Profile.self)
		profile.gpName = gpName
		profile.gpAccessCode = gpAccessCode
		profile.gpAddressLine = gpAddressLine
		profile.gpPostcode = gpPostcode
		profile.isPermisionEnabled = isPermisionEnabled
		profile.profileFilled = true
		
		DataController.saveEntity(managedObject: profile)
		
		goNextSegue!()
	}
}
