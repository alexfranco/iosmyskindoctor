//
//  MedicalHistoryViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 02/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MedicalHistoryViewModel: BaseViewModel {
	
	var model: MedicalHistory!
	
	var hasHealthProblems = false
	var healthProblemDescription: String = ""
	var hasMedication = false
	var hasPastHistoryProblems = false
	var saveMedicalHistory = false
	
	func saveModel() {
		model = DataController.createUniqueEntity(type: MedicalHistory.self)
		
		model.hasHealthProblems = hasHealthProblems
		model.healthProblemDescription = healthProblemDescription
		model.hasMedication = hasMedication
		model.hasPastHistoryProblems = hasPastHistoryProblems
		model.saveMedicalHistory = saveMedicalHistory
		DataController.saveEntity(managedObject: model)
		
		goNextSegue!()
	}
}
