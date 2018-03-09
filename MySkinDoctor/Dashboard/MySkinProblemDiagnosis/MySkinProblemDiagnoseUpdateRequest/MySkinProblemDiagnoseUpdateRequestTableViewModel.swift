//
//  MySkinProblemDiagnoseUpdateRequestTableViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 09/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class MySkinProblemDiagnoseUpdateRequestTableViewModel: NSObject {
	
	var note: String!
	var date: String!
	
	var model: DoctorNote!
	
	required init(withModel model: DoctorNote) {
		self.model = model
		self.date =  model.date.ordinalMonthAndYear()
		self.note = model.note
	
		super.init()
	}
}
