//
//  Diagnose+Extentions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 13/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension Diagnose {
	enum DiagnoseStatus: Int16, CustomStringConvertible {
		case unknown = 0
		case draft = 1
		case submitted = 2
		case noFutherCommunicationRequired = 4
		case bookConsultationRequested = 5
		case consultationBooked = 6

		var index: Int16 {
			return rawValue
		}

		var description: String {
			switch self {
			case .unknown:
				return NSLocalizedString("skinproblem_case_draft", comment: "")
			case .draft:
				return NSLocalizedString("skinproblem_case_draft", comment: "")
			case .submitted:
				return NSLocalizedString("skinproblem_case_submitted", comment: "")
			case .noFutherCommunicationRequired:
				return NSLocalizedString("skinproblem_case_no_further_ommunication_required", comment: "")
			case .bookConsultationRequested:
				return NSLocalizedString("skinproblem_case_book_consultation_request", comment: "")
			case .consultationBooked:
				return NSLocalizedString("skinproblem_case_consultation_booked", comment: "")
			}
		}
	}
	
	var diagnoseStatusEnum: DiagnoseStatus {
		get { return DiagnoseStatus(rawValue: self.diagnoseStatus )! }
		set { self.diagnoseStatus = Int16(newValue.rawValue) }
	}
	
}

