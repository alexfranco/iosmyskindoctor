//
//  MedicalHistoryModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 02/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class MedicalHistoryModel: NSObject {
	
	var hasHealthProblems = false
	var healthProblemDescription: String = ""
	var hasMedication = false
	var hasPastHistoryProblems = false
	
	override init() {
		super.init()
	}
	
	convenience init(hasHealthProblems: Bool, healthProblemDescription: String, hasMedication: Bool, hasPastHistoryProblems: Bool) {
		self.init()
		self.hasHealthProblems = hasHealthProblems
		self.healthProblemDescription = healthProblemDescription
		self.hasMedication = hasMedication
		self.hasPastHistoryProblems = hasPastHistoryProblems
	}
	
}


