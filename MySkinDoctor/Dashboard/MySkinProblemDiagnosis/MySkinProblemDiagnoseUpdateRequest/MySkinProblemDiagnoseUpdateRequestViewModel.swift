//
//  MySkinProblemDiagnoseUpdateRequestViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 09/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemDiagnoseUpdateRequestViewModel: BaseMySkinProblemDiagnosisViewModel {
	
	func getDataSourceCount() -> Int {
		return model.diagnose.doctorNotes.count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> DoctorNote {
		return model.diagnose.doctorNotes[indexPath.row]
	}
}
