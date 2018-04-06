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
			if let doctor = model.doctor, let firstName = doctor.firstName, let lastName = doctor.lastName {
				return firstName + " " + lastName
			} else {
				return  "-"
			}
		}
	}
	
	var profileImage: UIImage {
		get {
			if let doctor = model.doctor, let profilePicture = doctor.profilePicture as? UIImage {
				return profilePicture
			} else {
				return UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!				
			}
		}
	}
	
	var qualificationsText: String {
		get {
			if let qualifications = model.doctor!.qualifications {
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
		df.dateFormat = "HH.ssa"
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
