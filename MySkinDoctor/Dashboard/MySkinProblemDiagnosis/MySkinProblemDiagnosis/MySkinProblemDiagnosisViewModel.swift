//
//  MySkinProblemDiagnosisViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 08/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemDiagnosisViewModel: BaseMySkinProblemDiagnosisViewModel {
	var diagnosis: String {
		return self.model.diagnose!.summary ?? "-"
	}
	
	var treatment: String {
		return self.model.diagnose!.treatment ?? "-"
	}
	
	var patientInformation: String {
		return self.model.diagnose!.patientInformation ?? "-"
	}
	
	var comments: String {
		return self.model.diagnose!.comments ?? "-"
	}
}
