//
//  BaseMySkinProblemDiagnosisViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 09/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class BaseMySkinProblemDiagnosisViewModel: BaseViewModel {
	
	var model: SkinProblems!
	
	var diagnoseStatus: Diagnose.DiagnoseStatus {
		get {
			guard let diagnose = model.diagnose else {
				return Diagnose.DiagnoseStatus.none
			}
			
			return diagnose.diagnoseStatusEnum
		}
	}
	
	var shouldShowNextButton: Bool {
		guard let diagnose = model.diagnose else {
			return false
		}
		
		return diagnose.diagnoseStatusEnum == .bookConsultationRequest
	}
	
	var viewBackgroundColor: UIColor {
		get {
			switch diagnoseStatus {
			case .none:
				return UIColor.white
			case .submitted:
				return UIColor.white
			case .noFutherCommunicationRequired:
				return AppStyle.diagnoseViewBackgroundColor
			case .bookConsultationRequest:
				return AppStyle.diagnoseUpdateRequestViewBackgroundColor
			}
		}
	}
	
	var navigationTitle: String {
		get {
			switch diagnoseStatus {
			case .none:
				return ""
			case .submitted:
			   return ""
			case .noFutherCommunicationRequired:
				return "Diagnosis"
			case .bookConsultationRequest:
				return "Diagnosis Update"
			}
		}
	}
	
	var doctorNameText: String {
		get {
			if let diagnose = model.diagnose, let diagnosedBy = diagnose.doctor, let firstName = diagnosedBy.firstName, let lastName = diagnosedBy.lastName {
				return firstName + " " + lastName
			} else {
				return  "-"
			}
		}
	}
	
	var profileImage: UIImage {
		get {
			guard let diagnose = model.diagnose, let diagnosedBy = diagnose.doctor, let profilePicture = diagnosedBy.profilePicture else {
				return UIImage(named: "logo")!
			}
			
			return profilePicture as! UIImage
		}
	}
	
	var qualificationsText: String {
		get {
			guard let diagnose = model.diagnose, let diagnosedBy = diagnose.doctor, let qualifications = diagnosedBy.qualifications else {
				return "-"
			}
			
			return qualifications.uppercased()
		}
	}
	
	var appointmentDateText: String {
		get {
			return String.init(format: "%@ @ %@", dateText(), timeText())
		}
	}
	
	required init(model: SkinProblems) {
		super.init()
		self.model = model
	}
	
	private func dateText() -> String {
		return (model.date! as Date).ordinalMonthAndYear()
	}
	
	private func timeText() -> String {
		let df = DateFormatter()
		df.dateFormat = "HH.ss a"
		df.amSymbol = "am"
		df.pmSymbol = "pm"
		return df.string(from: (model.date! as Date))
	}
	
}
