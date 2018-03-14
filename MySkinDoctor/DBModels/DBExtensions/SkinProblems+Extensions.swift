//
//  SkinProblems+Extensions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 13/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension SkinProblems {
	
	var isDiagnosed: Bool {
		guard let diagnoseSafe = diagnose else {
			return false
		}
		
		return diagnoseSafe.diagnoseStatusEnum == .noFutherCommunicationRequired ||  diagnoseSafe.diagnoseStatusEnum == .bookConsultationRequest
	}
}
