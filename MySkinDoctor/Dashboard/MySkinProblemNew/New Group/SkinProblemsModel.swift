//
//  SkinProblems.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 01/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemsModel : NSObject {
	
	enum DiagnoseStatus: Int {
		case none
		case noDiagnosed
		case diagnosed
	}
	
	var date: Date
	var isSubmitted: Bool = false
	var diagnoseStatus: DiagnoseStatus = DiagnoseStatus.none
	var skinProblemDescription: String = ""
	var problems: [SkinProblemModel] = []
	
	override init() {
		date = Date()
		super.init()
	}
	
	convenience init(date: Date? = Date(), diagnoseStatus: DiagnoseStatus = DiagnoseStatus.none, skinProblemDescription: String = "") {
		self.init()
		
		self.date = date!
		self.diagnoseStatus = diagnoseStatus
		self.skinProblemDescription = skinProblemDescription
	}
}
