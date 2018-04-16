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
	
	var isConsultationTime: Bool {
		get {
			return model.isConsultationTime()
		}
	}
	
	var isBeforeConsultation: Bool {
		get {
			return model.isBeforeConsultation()
		}
	}
	
	var isCancelConsultationButtonEnabled: Bool {
		get {
			return isBeforeConsultation
		}
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
		isLoading = true
		
		ApiUtils.deleteAppointment(accessToken: DataController.getAccessToken(), skinProblemsId: Int(model.skinProblems!.skinProblemId), eventId: Int(model.appointmentId)) { (result) in
			self.isLoading = false
			
			print("deleteAppointment")
			
			switch result {
			case .success(_):
				if self.onFetchFinished != nil {
					self.onFetchFinished!()
				}
				
			case .failure(_, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(nil, error)
			}
		}
	}
	
	func startConsultation() {
		goNextSegue!()
	}
	
}
