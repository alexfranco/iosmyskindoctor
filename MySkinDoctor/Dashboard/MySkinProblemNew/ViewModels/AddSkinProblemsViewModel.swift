//
//  AddSkinProblemsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddSkinProblemsViewModel: BaseViewModel {
	
	private(set) var model: SkinProblems?
	var skinProblemDescription = ""

	// Bind properties
	var refresh: (()->())?
	var tableViewStageChanged: ((_ state: EditingStyle)->())?
	var updateNextButton: ((_ isEnabled: Bool)->())?
	var diagnosedStatusChanged: ((_ state: Diagnose.DiagnoseStatus)->())?
	var onSkinProblemAttachmentImageAdded: ((_ skinProblemAttachment: SkinProblemAttachment)->())?
	
	private(set) var tableViewState: EditingStyle = EditingStyle.none {
		didSet {
			guard let model = self.model else { return }
			
			switch tableViewState {
			case let .insert(new, _):
				let skinProblemAttachment = new
				model.addToAttachments(skinProblemAttachment)
			case let .delete(indexPath):
				if let attachment = model.attachments?.allObjects[indexPath.row] {
					model.removeFromAttachments(attachment as! SkinProblemAttachment)
				}
			default:
				break
			}
			
			tableViewStageChanged!(tableViewState)
		}
	}
	
	required init(modelId: NSManagedObjectID?) {
		super.init()
		
		if modelId == nil {
			createModel()
		} else {
			self.model = DataController.getManagedObject(managedObjectId: modelId!) as? SkinProblems
		}
		
		loadDBModel()
	}
	
	func createModel() {
		isLoading = true
		
		ApiUtils.createSkinProblem(accessToken: DataController.getAccessToken()) { (result) in
			
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("createSkinProblem")
				
				let modelCast =  model as! SkinProblemsResponseModel
				
				let persistentModel = DataController.createNew(type: SkinProblems.self)
				persistentModel.skinProblemId = Int16(modelCast.skinProblemId)
				DataController.saveEntity(managedObject: persistentModel)
				self.model = persistentModel
				
				self.refresh!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	override func loadDBModel() {
		super.loadDBModel()

		guard let model = self.model else { return }
		
		self.skinProblemDescription = model.skinProblemDescription	?? "-"
	}
	
	override func saveModel() {
		super.saveModel()
		
		guard let model = self.model else { return }
		
		var healthProblems: String?
		var pastHistoryProblems: String?
		var medication: String?
		
		if let medicalHistory = profileMedicalHistory() {
			healthProblems = medicalHistory.healthProblems
			pastHistoryProblems = medicalHistory.pastHistoryProblems
			medication = medicalHistory.medication
		}
		
		isLoading = true
		ApiUtils.updateSkinProblems(accessToken: DataController.getAccessToken(), skinProblemsId: Int(model.skinProblemId), skinProblemsDescription: skinProblemDescription, healthProblems: healthProblems, medications: medication, history: pastHistoryProblems) { (result) in
			
			switch result {
			case .success(let responseModel):
				print("updateSkinProblems")
				
				if self.hasProfileMedicalHistory {
					self.submitSkinProblems(responseModel: responseModel as! SkinProblemsResponseModel)
				} else {
					self.isLoading = false
					self.goNextSegue!()
				}
				
			case .failure(let model, let error):
				print("error")
				self.isLoading = false
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	private func submitSkinProblems(responseModel: SkinProblemsResponseModel) {
		ApiUtils.submitSkinProblem(accessToken: DataController.getAccessToken(), skinProblemsId: Int(self.model!.skinProblemId)) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("submitSkinProblem")
				SkinProblems.parseAndSaveResponse(skinProblemResponseModel: model as! SkinProblemsResponseModel)
				self.goNextSegue!()
				
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	func discardModel() {
		// TODO
	}
	
	func insertNewModel(model: SkinProblemAttachment, indexPath: IndexPath) {
		tableViewState = .insert(model, indexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
	
	func appendNewModel(skinProblemAttachment: SkinProblemAttachment) {
		guard let model = self.model else { return }
		
		isLoading = true
		
		ApiUtils.createSkinProblemAttachment(accessToken: DataController.getAccessToken(), skinProblemsId: Int(model.skinProblemId), location: skinProblemAttachment.locationTypeEnum.description, fileName: skinProblemAttachment.filename, description: skinProblemAttachment.problemDescription, attachmentType: skinProblemAttachment.attachmentTypeEnum, completionHandler: { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("createSkinProblemAttachment")
				let attachment = SkinProblemAttachment.parseAndSaveSkinProblemsAttachmentResponse(attachment: model as! SkinProblemAttachmentResponseModel)
				let appendToLastIndexPath = IndexPath.init(row: self.getDataSourceCountWithoutExtraAddPhoto(), section: 0)
				self.tableViewState = .insert(attachment, appendToLastIndexPath)
				self.updateNextButton!(self.nextButtonIsEnabled)
				
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		})
	}
	
	func removeModel(at indexPath: IndexPath) {
		tableViewState = .delete(indexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
	
	func createSkinProblemAttachment(image: UIImage) {
		let skinProblem = DataController.disconnectedEntity(type: SkinProblemAttachment.self)
		skinProblem.problemImage = image
		DataController.saveEntity(managedObject: skinProblem)
		onSkinProblemAttachmentImageAdded!(skinProblem)
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
			guard let model = self.model else { return Diagnose.DiagnoseStatus.none}
			
			guard let diagnose = model.diagnose else {
				return Diagnose.DiagnoseStatus.none
			}
			
			return diagnose.diagnoseStatusEnum
		}
	}
	
	var isDiagnosed: Bool {
		get {
			guard let model = self.model else { return false}
			
			return model.isDiagnosed
		}
	}
	
	var hasProfileMedicalHistory: Bool {
		get {
			return (profileMedicalHistory() != nil)
		}
	}
	
	var navigationTitle: String {
		get {
			switch diagnoseStatus {
			case .none:
				return NSLocalizedString("addskinproblems_main_vc_title_none", comment: "")
			case .submitted:
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
			case .submitted:
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
			guard let model = self.model else { return false }
			
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
			case .submitted:
				return generateNodiagnosedInfoText()
			case .noFutherCommunicationRequired:
				return generateDiagnosedInfoText()
			case .bookConsultationRequest:
				return generateDiagnosedFollowUpRequestInfoText()
			}
		}
	}
	
	var diagnoseNextSegue: String {
		get {
			switch diagnoseStatus {
			case .none:
				return ""
			case .submitted:
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
			return hasProfileMedicalHistory ? Segues.goToSkinProblemThankYouViewControllerFromAddSkinProblem : Segues.goToMedicalHistoryViewControler
		}
	}
	
	func profileMedicalHistory() -> MedicalHistory? {
		let profile = DataController.createUniqueEntity(type: Profile.self)
		return profile.medicalHistory
	}
	
	// MARK Helpers
	
	func refreshData() {
		updateNextButton!(nextButtonIsEnabled)
		refresh!()
	}
	
	func getDataSourceCount() -> Int {
		guard let model = self.model else { return 0 }
		
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
		guard let model = self.model else { return 0 }
		
		guard let attachments = model.attachments else {
			return 0
		}
		
		return attachments.count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblemAttachment? {
		guard let model = self.model else { return nil}
		
		return model.attachments?.allObjects[indexPath.row] as? SkinProblemAttachment
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
		return NSLocalizedString("addskinproblems_review", comment: "")
	}
	
	private func generateDiagnosedInfoText() -> String {
		
		guard let model = self.model else { return "-" }
		
		if let diagnose = model.diagnose,
			let doctor = diagnose.doctor,
			let doctorFirstName = doctor.firstName,
			let doctorLastName = doctor.lastName {
			let diagnoseDate = diagnose.diagnoseDate! as Date
			
			return String.init(format: "%@ %@ %@ %@.", doctorFirstName, doctorLastName, NSLocalizedString("addskinproblems_diagnosed", comment: ""),  diagnoseDate.ordinalMonthAndYear())
		} else {
			return "-"
		}
	}
	
	private func generateDiagnosedFollowUpRequestInfoText() -> String {
		return NSLocalizedString("addskinproblems_follow_up", comment: "")
	}
}
