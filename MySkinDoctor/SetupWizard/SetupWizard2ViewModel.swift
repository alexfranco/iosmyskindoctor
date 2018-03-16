//
//  SetupWizard2ViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation


class SetupWizard2ViewModel: BaseViewModel {
	
	var isNHS = false
	
	override init() {
		super.init()
	}
	
	func saveModel() {
		goNextSegue!()
	}
}
