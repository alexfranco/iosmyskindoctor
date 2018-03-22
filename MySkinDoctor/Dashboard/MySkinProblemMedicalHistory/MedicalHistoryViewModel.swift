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
	
	var healthProblems = ""
	var medication = ""
	var pastHistoryProblems = ""
	
	var hasHealthProblems = false {
		didSet {
			healthProblemsViewConstraintUpdate!(hasHealthProblems)
		}
	}
	
	var hasMedication = false {
		didSet {
			medicationViewConstraintUpdate!(hasMedication)
		}
	}
	
	var hasPastHistoryProblems = false {
		didSet {
			pastHistoryProblemsViewConstraintUpdate!(hasPastHistoryProblems)
		}
	}
	
	var saveMedicalHistory = false
	
	var healthProblemsViewConstraintUpdate: ((_ show: Bool)->())?
	var medicationViewConstraintUpdate: ((_ show: Bool)->())?
	var pastHistoryProblemsViewConstraintUpdate: ((_ show: Bool)->())?
	
	override init() {
		super.init()
		saveMedicalHistory = true
		hasHealthProblems = false
		hasMedication = false
		hasPastHistoryProblems = false
	}
	
	override func saveModel() {
		super.saveModel()
		
		// TOOD API
		
		if saveMedicalHistory {
			model.healthProblems = healthProblems
			model.medication = medication
			model.pastHistoryProblems = pastHistoryProblems
			
			model = DataController.createUniqueEntity(type: MedicalHistory.self)
			DataController.saveEntity(managedObject: model)
		}
		
		goNextSegue!()
	}
}
