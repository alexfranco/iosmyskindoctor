//
//  MySkinProblemsTableCellViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class MySkinProblemsTableCellViewModel: NSObject {
	
	static let dateFormat = "MMMM, yyyy"
	
	var name: String!
	var date: String!
	var isDiagnosed: Bool!
	var problemDescription: String!
	
	required init(withName name: String, date: Date, isDiagnosed: Bool, problemDescription: String) {
		
		self.name = name
		self.date = MySkinProblemsTableCellViewModel.getDateFormatted(date: date)
		self.isDiagnosed = isDiagnosed
		self.problemDescription = problemDescription
		
		super.init()
	}
	
	static func getDateFormatted(date: Date) -> String {
		// Formater
		let dateFormater = DateFormatter()
		dateFormater.dateFormat = dateFormat

		return (DateUtils.getOrdinaryDay(date: date) + " " + dateFormater.string(from: date)).uppercased()
	}
}
