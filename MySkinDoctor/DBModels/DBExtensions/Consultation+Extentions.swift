//
//  Consultation+Extentions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension Consultation {
	
	static func parseAndSaveResponse(consultationResponseModel: EventResponseModel) -> Consultation? {
		
		guard let skinProblems = DataController.fetch(objectIdKey: "skinProblemId", objectValue: consultationResponseModel.caseId, type: SkinProblems.self) else {
			return nil
		}
		
		let consultation = DataController.createOrUpdate(objectIdKey: "appointmentId", objectValue: consultationResponseModel.eventId, type: Consultation.self)
		consultation.appointmentId = Int16(consultationResponseModel.eventId)
		consultation.appointmentDate = consultationResponseModel.start! as NSDate
		consultation.duration = Int16(consultationResponseModel.duration)
		consultation.skinProblems = skinProblems
		
		DataController.saveEntity(managedObject: consultation)
		
		return consultation
	}
}
