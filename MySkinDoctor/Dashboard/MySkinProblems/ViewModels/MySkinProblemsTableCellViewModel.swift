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
	var model: SkinProblems!
	
	required init(withModel model: SkinProblems) {
		super.init()
		self.model = model
		
		guard let diagnose = model.diagnose else {
			return
		}
		
		self.name = diagnose.diagnoseStatus.description
		self.date = MySkinProblemsTableCellViewModel.getDateFormatted(date: model.date! as Date)
		self.isDiagnosed = model.isDiagnosed
		self.problemDescription = model.skinProblemDescription ?? "-"
	}
	
	static func getDateFormatted(date: Date) -> String {
		return date.ordinalMonthAndYear()
	}
}
