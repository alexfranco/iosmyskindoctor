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
	@objc enum DiagnoseStatus: Int, CustomStringConvertible {
		case none
		case pending
		case noFutherCommunicationRequired
		case bookConsultationRequest

		var index: Int {
			return rawValue
		}

		var description: String {
			switch self {
			case .none:
				return "None"
			case .pending:
				return "Pending"
			case .bookConsultationRequest:
				return "Consultation Request"
			case .noFutherCommunicationRequired:
				return "Futher comunication Required"
			}
		}
	}
	
	@NSManaged var diagnoseStatus: DiagnoseStatus
	
}

