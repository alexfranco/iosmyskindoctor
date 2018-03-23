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
		case none
		case submitted
		case noFutherCommunicationRequired
		case bookConsultationRequest

		var index: Int16 {
			return rawValue
		}

		var description: String {
			switch self {
			case .none:
				return "Draft"
			case .submitted:
				return "Pending"
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

