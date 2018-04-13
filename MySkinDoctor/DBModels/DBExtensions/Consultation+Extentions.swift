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
		consultation.isCancelled = consultationResponseModel.cancelled
		consultation.skinProblems = skinProblems
		
		DataController.saveEntity(managedObject: consultation)
		
		if consultation.isCancelled {
			// Remove notifications
			LocalNotifications.deleteAllEventNotifications(Int(consultation.appointmentId))
		} else {
			// Create notifications if it does not exist
			if let eventStart = consultation.appointmentDate,
				let skinProblems = consultation.skinProblems,
				let diagnose = skinProblems.diagnose,
				let doctor = diagnose.doctor,
				let expertName = doctor.displayName {
				
				LocalNotifications.createAllEventNotifications(Int(consultation.appointmentId), eventStart: eventStart as Date, expertName: expertName, firstReminderMinutes: Reminders.firstReminderMinutes, secondReminderMinutes: Reminders.secondReminderMinutes)
			}
		}
		
		return consultation
	}
	
	func isConsultationTime() -> Bool {
		
		if let appointmentDateSafe = appointmentDate as Date? {
			
			let now = Date()
			let nowMinusTwoMinutes = now.adjust(.minute, offset: -2)
			let nowEndDate = now.adjust(.minute, offset: 15)
			
			return appointmentDateSafe > nowMinusTwoMinutes && appointmentDateSafe < nowEndDate
		}
		
		return false
	}
	
	func isBeforeConsultation() -> Bool {
		
		if let appointmentDateSafe = appointmentDate as Date? {
			let now = Date()
			let nowMinusTwoMinutes = now.adjust(.minute, offset: -2)
			return appointmentDateSafe < nowMinusTwoMinutes
		}
		
		return false
	}
}
