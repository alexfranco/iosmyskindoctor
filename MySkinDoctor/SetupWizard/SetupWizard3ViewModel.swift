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
	var gpPostCode = ""
	var isPermisionEnabled = false
	
	override init() {		
		super.init()
	}
	
	func saveModel() {
		goNextSegue!()
	}
}
