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
	
	var healthProblemsUpdate: (()->())?
	var medicationUpdate: (()->())?
	var pastHistoryProblemsUpdate: (()->())?
	
	var healthProblemsViewConstraintUpdate: ((_ show: Bool)->())?
	var medicationViewConstraintUpdate: ((_ show: Bool)->())?
	var pastHistoryProblemsViewConstraintUpdate: ((_ show: Bool)->())?
	
	var hasProfileMedicalHistory: Bool {
		get {
			return (profileMedicalHistory() != nil)
		}
	}
	
	func profileMedicalHistory() -> MedicalHistory? {
		let profile = DataController.createUniqueEntity(type: Profile.self)
		return profile.medicalHistory
	}
	
	
	required init(modelId: NSManagedObjectID) {
		super.init()
		
		model = DataController.getManagedObject(managedObjectId: modelId) as! SkinProblems		
	}
	
	func loadProfileMedicalHistory() {
		if let medicalHistory = profileMedicalHistory() {
			healthProblems = medicalHistory.healthProblems ?? ""
			medication = medicalHistory.medication ?? ""
			pastHistoryProblems = medicalHistory.pastHistoryProblems ?? ""
			
			healthProblemsUpdate!()
			medicationUpdate!()
			pastHistoryProblemsUpdate!()
			
			hasHealthProblems = !healthProblems.isEmpty
			hasMedication = !medication.isEmpty
			hasPastHistoryProblems = !pastHistoryProblems.isEmpty
			
			saveMedicalHistory = false
		} else {
			saveMedicalHistory = true
		}
	}
	
	override func saveModel() {
		super.saveModel()
		
		self.isLoading = true
		ApiUtils.updateSkinProblems(accessToken: DataController.getAccessToken(), skinProblemsId: Int(model.skinProblemId), skinProblemsDescription: nil, healthProblems: healthProblems, medications: medication, history: pastHistoryProblems) { (result) in
			
			switch result {
			case .success(let model):
				print("updateSkinProblems")
				SkinProblems.parseAndSaveResponse(skinProblemResponseModel: model as! SkinProblemsResponseModel)
				self.submitSkinProblems()
				
			case .failure(let model, let error):
				print("error")
				self.isLoading = false
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	private func submitSkinProblems() {		
		ApiUtils.submitSkinProblem(accessToken: DataController.getAccessToken(), skinProblemsId: Int(self.model.skinProblemId)) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("submitSkinProblem")
				SkinProblems.parseAndSaveResponse(skinProblemResponseModel: model as! SkinProblemsResponseModel)
				self.updateProfileMedicalHistory()
				self.goNextSegue!()
				
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	private func updateProfileMedicalHistory() {
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
