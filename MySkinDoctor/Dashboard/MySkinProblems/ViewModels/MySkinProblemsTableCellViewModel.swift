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
	
	let diagnosedImageName = "diagnosed"
	let undiagnosedImageName = "undiagnosed"
	
	var name: String!
	var date: String!
	var problemDescription: String!
	var model: SkinProblems!
	
	required init(withModel model: SkinProblems) {
		super.init()
		self.model = model
		
		guard let diagnose = model.diagnose else {
			return
		}
		
		self.name = diagnose.diagnoseStatusEnum.description
		self.date = MySkinProblemsTableCellViewModel.getDateFormatted(date: model.date! as Date)
		self.problemDescription = model.skinProblemDescription ?? "-"
	}
	
	var diagnoseTextColor: UIColor {
		return model.isDiagnosed ? AppStyle.mySkinDiagnosedColor : AppStyle.mySkinUndiagnosedColor
	}

	var tableViewBackground: UIColor {
		return model.isDiagnosed ? AppStyle.mySkinProblemsDiagnoseTableViewBackground : AppStyle.mySkinProblemsUndiagnoseTableViewBackground
	}

	var icon : UIImage {
		return (model.isDiagnosed ? UIImage(named: diagnosedImageName) : UIImage(named: undiagnosedImageName))!
	}
	
	static func getDateFormatted(date: Date) -> String {
		return date.ordinalMonthAndYear()
	}
}
