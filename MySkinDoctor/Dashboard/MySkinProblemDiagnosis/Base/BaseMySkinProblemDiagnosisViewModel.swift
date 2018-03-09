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
	
	var model: SkinProblemsModel!
	
	var diagnoseStatus: Diagnose.DiagnoseStatus {
		get {
			return model.diagnose.diagnoseStatus
		}
	}
	
	var shouldShowNextButton: Bool {
		return model.diagnose.diagnoseStatus == .bookConsultationRequest
	}
	
	var viewBackgroundColor: UIColor {
		get {
			switch diagnoseStatus {
			case .none:
				return UIColor.white
			case .pending:
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
			case .pending:
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
			if let diagnosedBy = model.diagnose.diagnosedBy, let firstName = diagnosedBy.firstName, let lastName = diagnosedBy.lastName {
				return firstName + " " + lastName
			} else {
				return  "-"
			}
		}
	}
	
	var profileImage: UIImage {
		get {
			guard let diagnosedBy = model.diagnose.diagnosedBy, let profileImage = diagnosedBy.profileImage else {
				return UIImage(named: "logo")!
			}
			
			return profileImage
		}
	}
	
	var qualificationsText: String {
		get {
			guard let diagnosedBy = model.diagnose.diagnosedBy, let qualifications = diagnosedBy.qualifications else {
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
	
	required init(model: SkinProblemsModel) {
		super.init()
		self.model = model
	}
	
	private func dateText() -> String {
		return model.date.ordinalMonthAndYear()
	}
	
	private func timeText() -> String {
		let df = DateFormatter()
		df.dateFormat = "HH.ss a"
		df.amSymbol = "am"
		df.pmSymbol = "pm"
		return df.string(from: model.date)
	}
	
}
