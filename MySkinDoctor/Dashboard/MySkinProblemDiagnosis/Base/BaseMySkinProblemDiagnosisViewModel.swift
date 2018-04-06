//
//  BaseMySkinProblemDiagnosisViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 09/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BaseMySkinProblemDiagnosisViewModel: BaseViewModel {
	
	var model: SkinProblems!
	
	var skinProblemsManagedId: NSManagedObjectID {
		return model.objectID
	}
	
	var diagnoseStatus: Diagnose.DiagnoseStatus {
		get {
			guard let diagnose = model.diagnose else {
				return Diagnose.DiagnoseStatus.draft
			}
			
			return diagnose.diagnoseStatusEnum
		}
	}
	
	var viewBackgroundColor: UIColor {
		get {
			switch diagnoseStatus {
			case .unknown, .draft, .submitted, .consultationBooked:
				return UIColor.white
			case .noFutherCommunicationRequired:
				return AppStyle.diagnoseViewBackgroundColor
			case .bookConsultationRequested:
				return AppStyle.diagnoseUpdateRequestViewBackgroundColor
			}
		}
	}
	
	var navigationTitle: String {
		get {
			switch diagnoseStatus {
			case .unknown, .draft, .submitted, .consultationBooked:
				return ""
			case .noFutherCommunicationRequired:
				return NSLocalizedString("myskinproblem_diagnosis_vc_title", comment: "")
			case .bookConsultationRequested:
				return NSLocalizedString("myskinproblem_diagnosis_update_vc_title", comment: "")
			}
		}
	}
	
	var doctorNameText: String {
		get {
			if let diagnose = model.diagnose, let diagnosedBy = diagnose.doctor, let displayName = diagnosedBy.displayName {
				return displayName
			} else {
				return  "-"
			}
		}
	}
	
	var profileImage: UIImage {
		get {
			guard let diagnose = model.diagnose, let diagnosedBy = diagnose.doctor, let profilePicture = diagnosedBy.profilePicture else {
				return UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
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
		df.dateFormat = "hh.ss a"
		df.amSymbol = "am"
		df.pmSymbol = "pm"
		return df.string(from: (model.date! as Date))
	}
	
}
