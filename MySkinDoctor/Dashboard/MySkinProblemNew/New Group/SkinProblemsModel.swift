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
	var isDiagnosed: Bool = false
	var skinProblemDescription: String = ""
	var problems: [SkinProblemModel] = []
	
	override init() {
		date = Date()
		super.init()
	}
	
	convenience init(date: Date? = Date(), isDiagnosed: Bool = false, skinProblemDescription: String = "") {
		self.init()
		
		self.date = date!
		self.isDiagnosed = isDiagnosed
		self.skinProblemDescription = skinProblemDescription
	}
}
