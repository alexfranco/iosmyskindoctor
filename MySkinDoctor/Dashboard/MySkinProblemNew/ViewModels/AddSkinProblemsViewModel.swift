//
//  AddSkinProblemsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class AddSkinProblemsViewModel: BaseViewModel {
	
	private(set) var model: SkinProblems
	var skinProblemDescription = ""

	// Bind properties
	var refresh: (()->())?
	var tableViewStageChanged: ((_ state: EditingStyle)->())?
	var updateNextButton: ((_ isEnabled: Bool)->())?
	var diagnosedStatusChanged: ((_ state: Diagnose.DiagnoseStatus)->())?
	
	private(set) var tableViewState: EditingStyle = EditingStyle.none {
		didSet {
			
			switch tableViewState {
			case let .insert(new, _):
				let skinProblemAttachment = new
				self.model.addToAttachments(skinProblemAttachment)
			case let .delete(indexPath):
				if let attachment = self.model.attachments?.allObjects[indexPath.row] {
					self.model.removeFromAttachments(attachment as! SkinProblemAttachment)
				}
			default:
				break
			}
			
			tableViewStageChanged!(tableViewState)
		}
	}
	
	override init() {
		// temporal object
		model = DataController.disconnectedEntity(type: SkinProblems.self)
		super.init()
	}
	
	init (model: SkinProblems){
		self.model = model
		self.skinProblemDescription = self.model.skinProblemDescription	?? "-"
		super.init()
	}
	
	override func saveModel() {
		super.saveModel()
		
		guard let medicalHistory = self.model.medicalHistory else { return }
		
		self.isLoading = true
		
		ApiUtils.createSkinProblem(accessToken: DataController.getAccessToken(), skinProblemsDescription: skinProblemDescription, healthProblems: medicalHistory.healthProblems, medications: medicalHistory.medication, history: model.medicalHistory?.pastHistoryProblems) { (result) in
	
			self.isLoading = false
			
			switch result {
			case .success(_):
				print("saveSkinProblem")
				
				let persistentModel = DataController.createNew(type: SkinProblems.self)
				persistentModel.skinProblemDescription = self.skinProblemDescription
				
				for attachment in (self.model.attachments?.allObjects)! {
					let persistentAttachment = DataController.createNew(type: SkinProblemAttachment.self)
					let attachmentCast = attachment as! SkinProblemAttachment
					persistentAttachment.attachmentType = attachmentCast.attachmentType
					persistentAttachment.problemDescription = attachmentCast.problemDescription
					persistentAttachment.locationType = attachmentCast.locationType
					persistentAttachment.problemImage = attachmentCast.problemImage
					persistentModel.addToAttachments(persistentAttachment)
				}
				
				persistentModel.diagnose = DataController.createNew(type: Diagnose.self)
				persistentModel.diagnose?.diagnoseStatusEnum = .pending
				
				DataController.saveEntity(managedObject: persistentModel)
				
				self.goNextSegue!()
				
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
}

extension AddSkinProblemsViewModel {
	enum EditingStyle {
		case insert(SkinProblemAttachment, IndexPath)
		case delete(IndexPath)
		case none
	}
	
	var isEditEnabled: Bool {
		get {
			return diagnoseStatus == .none
		}
	}
	
	var diagnoseStatus: Diagnose.DiagnoseStatus {
		get {
			guard let diagnose = model.diagnose else {
				return Diagnose.DiagnoseStatus.none
			}
			
			return diagnose.diagnoseStatusEnum
		}
	}
	
	var isDiagnosed: Bool {
		get {
			return model.isDiagnosed
		}
	}
	
	var hasMedicalHistory: Bool {
		get {
			if let medicalHistory = DataController.fetchAll(type: MedicalHistory.self), let _ = medicalHistory.first {
				return true
			} else {
				return false
			}
		}
	}
	
	var navigationTitle: String {
		get {
			switch diagnoseStatus {
			case .none:
				return NSLocalizedString("addskinproblems_main_vc_title_none", comment: "")
			case .pending:
				return NSLocalizedString("addskinproblems_main_vc_title_nodiagnosed", comment: "")
			case .noFutherCommunicationRequired:
				return NSLocalizedString("addskinproblems_main_vc_title_diagnosed", comment: "")
			case .bookConsultationRequest:
				return NSLocalizedString("addskinproblems_main_vc_title_diagnosed_update_request", comment: "")
			}
		}
	}
	
	var infoViewBackground: UIColor {
		get {
			switch diagnoseStatus {
			case .none:
				return UIColor.white
			case .pending:
				return AppStyle.addSkinProblemUndiagnosedViewBackground
			case .noFutherCommunicationRequired:
				return AppStyle.addSkinProblemDiagnosedViewBackground
			case .bookConsultationRequest:
				return AppStyle.addSkinProblemDiagnosedUpdateRequestViewBackground
			}
		}
	}
	
	var nextButtonIsEnabled: Bool {
		get {
			guard let attachments = model.attachments else {
				return true
			}
			
			return attachments.count > 0
		}
	}
	
	
	var diagnoseInfoText: String {
		get {
			switch diagnoseStatus {
			case .none:
				return "-"
			case .pending:
				return generateNodiagnosedInfoText()
			case .noFutherCommunicationRequired:
				return generateDiagnosedInfoText()
			case .bookConsultationRequest:
				return generateDiagnosedUpdateRequestInfoText()
			}
		}
	}
	
	var diagnoseNextSegue: String {
		get {
			switch diagnoseStatus {
			case .none:
				return ""
			case .pending:
				return ""
			case .noFutherCommunicationRequired:
				return Segues.goToDiagnosis
			case .bookConsultationRequest:
				return Segues.goToMySkinProblemDiagnoseUpdateRequest
			}
		}
	}
	
	var nextSegue: String! {
		get {
			return hasMedicalHistory ? Segues.goToSkinProblemThankYouViewControllerFromAddSkinProblem : Segues.goToMedicalHistoryViewControler
		}
	}
	
	// MARK Helpers
	
	func refreshData() {
		updateNextButton!(nextButtonIsEnabled)
		refresh!()
	}
	
	func getDataSourceCount() -> Int {
		guard let attachments = model.attachments else {
			return 0
		}
		
		var count = attachments.count
		
		if isEditEnabled {
			count += 1
		}
		
		return count
	}
	
	func getDataSourceCountWithoutExtraAddPhoto() -> Int {
		guard let attachments = model.attachments else {
			return 0
		}
		
		return attachments.count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblemAttachment {
		return model.attachments?.allObjects[indexPath.row] as! SkinProblemAttachment
	}
	
	func getNumberOfSections() -> Int {
		return 1
	}
	
	func canEditRow(indexPath: IndexPath) -> Bool {
		if isEditEnabled {
			return isAddPhotoRow(indexPath: indexPath)
		} else {
			return false
		}
	}
	
	
	func isAddPhotoRow(indexPath: IndexPath) -> Bool {
		if isEditEnabled {
			return getDataSourceCount() == indexPath.row + 1
		} else {
			return false
		}
	}
	
	private func generateNodiagnosedInfoText() -> String {
		return "Your skin problem is currently been reviewed by a consultant. Please check back later for diagnosis."
	}
	
	private func generateDiagnosedInfoText() -> String {
		if let diagnose = model.diagnose,
			let doctor = diagnose.doctor,
			let doctorFirstName = doctor.firstName,
			let doctorLastName = doctor.lastName {
			let diagnoseDate = diagnose.diagnoseDate! as Date
			
			return String.init(format: "%@ %@ diagnosed your skin condition on %@.", doctorFirstName, doctorLastName, diagnoseDate.ordinalMonthAndYear())
		} else {
			return "-"
		}
	}
	
	private func generateDiagnosedUpdateRequestInfoText() -> String {
		if let diagnose = model.diagnose,
			let doctor = diagnose.doctor,
			let doctorFirstName = doctor.firstName,
			let doctorLastName = doctor.lastName {
			
			return String.init(format: "%@ %@ has requested more information from you.", doctorFirstName, doctorLastName)
		} else {
			return "-"
		}
	}
	
	private func generateDiagnosedFollowUpRequestInfoText() -> String {
		if let diagnose = model.diagnose,
			let doctor = diagnose.doctor,
			let doctorFirstName = doctor.firstName,
			let doctorLastName = doctor.lastName {
			
			return String.init(format: "%@ %@ has requested a follow up from you.", doctorFirstName, doctorLastName)
		} else {
			return "-"
		}
	}
	
	func insertNewModel(model: SkinProblemAttachment, indexPath: IndexPath) {
		tableViewState = .insert(model, indexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
	
	func appendNewModel(model: SkinProblemAttachment) {
		let appendToLastIndexPath = IndexPath.init(row: getDataSourceCountWithoutExtraAddPhoto(), section: 0)
		tableViewState = .insert(model, appendToLastIndexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
	
	func removeModel(at indexPath: IndexPath) {
		tableViewState = .delete(indexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
}
