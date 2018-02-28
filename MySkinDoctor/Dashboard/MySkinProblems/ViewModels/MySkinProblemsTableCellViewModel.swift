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
	
	static let dateFormat = "MMMM, yyyy"
	
	var name: String!
	var date: String!
	var isDiagnosed: Bool!
	var problemDescription: String!
	
	required init(withModel model: SkinProblemModel) {
		
		self.name = model.name
		self.date = model.date == nil ? "-" : MySkinProblemsTableCellViewModel.getDateFormatted(date: model.date!)
		self.isDiagnosed = model.isDiagnosed
		self.problemDescription = model.problemDescription
		
		super.init()
	}
	
	static func getDateFormatted(date: Date) -> String {
		// Formater
		let dateFormater = DateFormatter()
		dateFormater.dateFormat = dateFormat
		
		return (DateUtils.getOrdinaryDay(date: date) + " " + dateFormater.string(from: date)).uppercased()
	}
}
