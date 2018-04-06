//
//  MyConsultDetailsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 14/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyConsultDetailsViewModel: BaseViewModel {
	
	var model: Consultation!
	
	func isConsultationTime() -> Bool {
		let now = Date()
		if let appointmentDate = model.appointmentDate as Date? {
			return appointmentDate > now && appointmentDate < now.adjust(.hour, offset: 15)
		}
		return false
	}
	
	func isBeforeConsultation() -> Bool {
		let now = Date()
		if let appointmentDate = model.appointmentDate as Date? {
			return appointmentDate > now
		}
		return false
	}

	var doctorNameText: String {
		get {
			if let skinProblems = model.skinProblems, let diagnose = skinProblems.diagnose, let doctor = diagnose.doctor, let displayName = doctor.displayName {
				return displayName
			} else {
				return  "-"
			}
		}
	}
	
	var profileImageUrl: String {
		get {
			guard let skinProblems = model.skinProblems, let diagnose = skinProblems.diagnose, let diagnosedBy = diagnose.doctor, let profilePictureUrl = diagnosedBy.profilePictureUrl else {
				return ""
			}
			
			return profilePictureUrl
		}
	}
	
	var qualificationsText: String {
		get {
			if let skinProblems = model.skinProblems, let diagnose = skinProblems.diagnose, let doctor = diagnose.doctor, let qualifications = doctor.qualifications {
				return qualifications.uppercased()
			}
			
			return ""
		}
	}
	
	var appointmentDateText: String {
		get {
			return String.init(format: "%@ @ %@", dateText(), timeText())
		}
	}
	
	required init(modelId: NSManagedObjectID) {
		super.init()
		self.model = DataController.getManagedObject(managedObjectId: modelId) as! Consultation
	}
	
	func dateText() -> String {
		return (model.appointmentDate! as Date).ordinalMonthAndYear()
	}
	
	func timeText() -> String {
		let df = DateFormatter()
		df.dateFormat = "HH.mma"
		df.amSymbol = "am"
		df.pmSymbol = "pm"
		return df.string(from: model.appointmentDate! as Date)
	}
	
	func cancelConsultation() {
		
	}
	
	func startConsultation() {
		goNextSegue!()
	}
	
}
