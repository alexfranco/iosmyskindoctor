//
//  SkinProblems+Extensions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 13/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension SkinProblems {
	
	var isDiagnosed: Bool {
		guard let diagnoseSafe = diagnose else {
			return false
		}
		
		return diagnoseSafe.diagnoseStatusEnum == .noFutherCommunicationRequired ||  diagnoseSafe.diagnoseStatusEnum == .bookConsultationRequest
	}
	
	static func parseAndSaveResponse(skinProblemResponseModel: SkinProblemsResponseModel) -> SkinProblems {
		var skinProblem = DataController.createOrUpdate(objectIdKey: "skinProblemId", objectValue: skinProblemResponseModel.skinProblemId, type: SkinProblems.self)
		
		skinProblem.skinProblemId = Int16(skinProblemResponseModel.skinProblemId)
		skinProblem.skinProblemDescription = skinProblemResponseModel.skinProblemDescription
		skinProblem.date = skinProblemResponseModel.dateCreated as NSDate?
		
		if skinProblem.medicalHistory == nil {
			skinProblem.medicalHistory = DataController.createNew(type: MedicalHistory.self)
		}
		
		skinProblem.medicalHistory!.healthProblems = skinProblemResponseModel.healthProblems
		skinProblem.medicalHistory!.medication = skinProblemResponseModel.medications
		skinProblem.medicalHistory!.pastHistoryProblems = skinProblemResponseModel.history
		
		if skinProblem.diagnose == nil {
			skinProblem.diagnose = DataController.createNew(type: Diagnose.self)
		}
		
		skinProblem.diagnose!.treatment = skinProblemResponseModel.diagnosisTreatment
		skinProblem.diagnose!.patientInformation = skinProblemResponseModel.diagnosisPatientInformation
		skinProblem.diagnose!.comments = skinProblemResponseModel.diagnosisComments
		skinProblem.diagnose!.diagnoseDate = skinProblemResponseModel.outcomeDate as NSDate?
		skinProblem.diagnose!.diagnoseStatus = Int16(skinProblemResponseModel.status)
		
		parseAndSaveSkinProblemsAttachmentResponse(skinProblemsResponseModel: skinProblemResponseModel, skinProblems: &skinProblem)
		
		DataController.saveEntity(managedObject: skinProblem)
		
		return skinProblem
	}
	
	static func parseAndSaveSkinProblemsAttachmentResponse(skinProblemsResponseModel:  SkinProblemsResponseModel, skinProblems: inout SkinProblems) {
		for attachment in skinProblemsResponseModel.attachments {
			let localAttachment = SkinProblemAttachment.parseAndSaveSkinProblemsAttachmentResponse(attachment: attachment)
			skinProblems.addToAttachments(localAttachment)
		}
	}
}
