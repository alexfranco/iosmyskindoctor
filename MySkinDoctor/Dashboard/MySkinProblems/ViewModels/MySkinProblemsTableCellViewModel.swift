//
//  MySkinProblemsTableCellViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemsTableCellViewModel: NSObject {
	
	var name: String!
	var date: String!
	var isDiagnosed: Bool!
	var problemDescription: String!
	var model: SkinProblemsModel!
	
	required init(withModel model: SkinProblemsModel) {
		self.model = model
		self.date = MySkinProblemsTableCellViewModel.getDateFormatted(date: model.date)
		self.isDiagnosed = model.diagnose.diagnoseStatus == .diagnosed
		self.problemDescription = model.skinProblemDescription
		
		super.init()
	}
	
	static func getDateFormatted(date: Date) -> String {
		return date.ordinalMonthAndYear()
	}
}
