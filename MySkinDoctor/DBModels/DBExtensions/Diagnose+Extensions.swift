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
		case bookConsultationRequest = 3
		case noFutherCommunicationRequired = 4

		var index: Int16 {
			return rawValue
		}

		var description: String {
			switch self {
			case .unknown:
				return "Draft"
			case .draft:
				return "Draft"
			case .submitted:
				return "Submitted"
			case .bookConsultationRequest:
				return "Consultation Request"
			case .noFutherCommunicationRequired:
				return "Futher comunication Required"
			}
		}
	}
	
	var diagnoseStatusEnum: DiagnoseStatus {
		get { return DiagnoseStatus(rawValue: self.diagnoseStatus )! }
		set { self.diagnoseStatus = Int16(newValue.rawValue) }
	}
	
}

