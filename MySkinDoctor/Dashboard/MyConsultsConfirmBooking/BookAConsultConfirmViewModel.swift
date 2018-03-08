//
//  BookAConsultConfirmViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 07/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class BookAConsultConfirmViewModel: BaseViewModel {
	
	var model: ConsultModel!

	required init(model: ConsultModel) {
		super.init()
		self.model = model
	}
	
	var dateLabelText: String {
		get {
			return model.date.ordinalMonthAndYear()
		}
	}
	
	var timeLabelText: String {
		get {
			let df = DateFormatter()
			df.dateFormat = "HH:ss a"
			df.amSymbol = "AM"
			df.pmSymbol = "PM"
			return df.string(from: model.date)
		}
	}
	
	func saveModel() {
		// TODO web api
		self.model.firstName = "Dr Jane"
		self.model.lastName = "Doe"
		self.model.qualification = "A lot of qualifications"		
		goNextSegue!()
	}
	
}
