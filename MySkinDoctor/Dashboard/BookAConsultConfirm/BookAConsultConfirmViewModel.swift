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
	
	func dateLabelText() -> String {
		let df = DateFormatter()
		df.dateFormat = "MMMM YYYY"
		return model.date.ordinal() + " " + df.string(from: model.date)
	}
	
	func timeLabelText() -> String {
		let df = DateFormatter()
		df.dateFormat = "HH:ss a"
		df.amSymbol = "AM"
		df.pmSymbol = "PM"
		return df.string(from: model.date)
	}
	
	func saveModel() {
		// TODO web api
		goNextSegue!()
	}
	
}
