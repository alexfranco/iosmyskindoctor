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
	
	var date: Date
	var isSubmitted: Bool = false
	var skinProblemDescription: String = ""
	var problems: [SkinProblemModel] = []
	
	var diagnose: Diagnose!
	
	var isDiagnosed: Bool {
		return diagnose.diagnoseStatus == .diagnosed || diagnose.diagnoseStatus == .diagnosedUpdateRequest
	}
	
	override init() {
		date = Date()
		diagnose = Diagnose()
		super.init()
	}
	
	convenience init(date: Date? = Date(), diagnoseStatus: Diagnose.DiagnoseStatus = .none, skinProblemDescription: String = "") {
		self.init()
		
		self.date = date!
		self.diagnose = Diagnose()
		self.diagnose.diagnoseStatus = diagnoseStatus
		self.skinProblemDescription = skinProblemDescription
	}
}

class Diagnose : NSObject {
	enum DiagnoseStatus: Int {
		case none
		case noDiagnosed
		case diagnosed
		case diagnosedUpdateRequest
	}
	
	var diagnoseDate: Date?
	var diagnosedBy: Doctor?
	var diagnoseStatus: DiagnoseStatus = DiagnoseStatus.none
}

class Doctor : NSObject {
	var firstName: String?
	var lastName: String?
	
	required init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
}
