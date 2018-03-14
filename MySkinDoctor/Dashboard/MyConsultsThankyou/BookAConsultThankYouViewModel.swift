//
//  BookAConsultThankYouViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 07/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookAConsultThankYouViewModel: BaseViewModel {
	
	var model: Consultation!
	
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
				return UIImage(named: "logo")!
			}
		}
	}
	
	var qualificationsText: String {
		get {
			return model.doctor!.qualifications ?? "-"
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
		df.dateFormat = "HH.ss a"
		df.amSymbol = "am"
		df.pmSymbol = "pm"
		return df.string(from: model.appointmentDate! as Date)
	}
		
}
