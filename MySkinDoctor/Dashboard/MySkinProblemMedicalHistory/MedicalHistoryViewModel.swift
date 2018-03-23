//
//  MedicalHistoryViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 02/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MedicalHistoryViewModel: BaseViewModel {
	
	var model: SkinProblems!
	
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
	
	required init(modelId: NSManagedObjectID) {
		super.init()
		
		model = DataController.getManagedObject(managedObjectId: modelId) as! SkinProblems
		
		saveMedicalHistory = true
		hasHealthProblems = false
		hasMedication = false
		hasPastHistoryProblems = false				
	}
	
	override func saveModel() {
		super.saveModel()
		
		self.isLoading = true
		ApiUtils.updateSkinProblems(accessToken: DataController.getAccessToken(), skinProblemsId: Int(model.skinProblemId), skinProblemsDescription: nil, healthProblems: healthProblems, medications: medication, history: pastHistoryProblems) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(_):
				print("updateSkinProblems")
				self.saveLocalModel()
				self.goNextSegue!()
				
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	func saveLocalModel() {
		if self.model.diagnose == nil {
			self.model.diagnose = DataController.createNew(type: Diagnose.self)
		}
		self.model.diagnose?.diagnoseStatusEnum = .submitted
		
		if self.model.medicalHistory == nil {
			self.model.medicalHistory = DataController.createNew(type: MedicalHistory.self)
		}
		
		self.model.medicalHistory?.healthProblems = self.healthProblems
		self.model.medicalHistory?.pastHistoryProblems = self.pastHistoryProblems
		self.model.medicalHistory?.medication = self.medication
		
		DataController.saveEntity(managedObject: self.model)
		
		self.updateProfileMedicalHistory()
	}
	
	func updateProfileMedicalHistory() {
		if saveMedicalHistory {
			let profile = DataController.createUniqueEntity(type: Profile.self)
			
			if profile.medicalHistory == nil {
				profile.medicalHistory = DataController.createNew(type: MedicalHistory.self)
			}
			
			profile.medicalHistory!.healthProblems = healthProblems
			profile.medicalHistory!.medication = medication
			profile.medicalHistory!.pastHistoryProblems = pastHistoryProblems
			DataController.saveEntity(managedObject: profile)
		}
	}
	
}
