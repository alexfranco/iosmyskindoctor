//
//  MySkinProblemDiagnoseViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 08/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemDiagnoseViewModel: BaseViewModel {
	
	var model: SkinProblemsModel!
	
	var viewBackgroundColor: UIColor {
		get {
			switch diagnoseStatus {
			case .none:
				return UIColor.white
			case .noDiagnosed:
				return UIColor.white
			case .diagnosed:
				return AppStyle.diagnoseViewBackgroundColor
			case .diagnosedUpdateRequest:
				return AppStyle.diagnoseUpdateRequestViewBackgroundColor
			}
		}
	}
	
	var diagnoseStatus: Diagnose.DiagnoseStatus {
		get {
			return model.diagnose.diagnoseStatus
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
			
			return qualifications
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
	
	
	func dateText() -> String {
		return model.date.ordinalMonthAndYear()
	}
	
	func timeText() -> String {
		let df = DateFormatter()
		df.dateFormat = "HH.ss a"
		df.amSymbol = "am"
		df.pmSymbol = "pm"
		return df.string(from: model.date)
	}
	
}
