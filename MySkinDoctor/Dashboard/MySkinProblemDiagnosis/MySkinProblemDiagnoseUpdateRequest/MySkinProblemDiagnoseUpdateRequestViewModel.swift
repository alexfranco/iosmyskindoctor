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
		guard let diagnose = model.diagnose, let doctorNotes = diagnose.doctorNotes else {
			return 0
		}
		return doctorNotes.count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> DoctorNotes {
		return model.diagnose!.doctorNotes?.allObjects[indexPath.row] as! DoctorNotes
	}
}
