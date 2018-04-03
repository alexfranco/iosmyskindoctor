//
//  SkinProblemsResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class SkinProblemsResponseModel : BaseResponseModel {

	var skinProblemId: Int = 0
	var skinProblemDescription: String?
	var healthProblems: String?
	var medications: String?
	var history: String?
	var dateCreated: Date?
	var outcome: Int = 0
	var outcomeDate: Date?
	var diagnosisName: String?
	var diagnosisTreatment: String?
	var diagnosisPatientInformation: String?
	var diagnosisComments: String?
	var status: Int = 0
	var diagnosisResources: [DiagnoseAttachmentResponseModel] = []
	var attachments: [SkinProblemAttachmentResponseModel] = []
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		skinProblemId <- map["id"]
		skinProblemDescription <- map["description"]
		healthProblems <- map["health_problems"]
		medications <- map["medications"]
		history <- map["history"]
		dateCreated <- map["date_created"]
		outcome <- map["outcome"]
		outcomeDate <- map["outcome_date"]
		diagnosisName <- map["diagnosis_name"]
		diagnosisTreatment <- map["diagnosis_treatment"]
		diagnosisPatientInformation <- map["diagnosis_patient_information"]
		diagnosisComments <- map["diagnosis_comments"]
		status <- map["status"]
		attachments <- map["images"]
		
		if let dateString = map["date_created"].currentValue as? String, let _date = Formatter.iso8601.date(from: dateString) { dateCreated = _date }
		
		if let dateString = map["outcome_date"].currentValue as? String, let _date = Formatter.iso8601.date(from: dateString) { outcomeDate = _date }
		
		diagnosisResources <- map["diagnosis_resources"]
	}
}
