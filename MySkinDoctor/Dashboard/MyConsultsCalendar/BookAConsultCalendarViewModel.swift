//
//  BookAConsultCalendarViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class BookAConsultCalendarViewModel: BaseViewModel {
	
	var model: ConsultModel?
	
	var selectedDate = Date() {
		didSet {
			selectedDateUpdated!(selectedDate)
		}
	}
	
	var selectedDateUpdated: ((_ date: Date)->())?
	
	var monthLabelText: String {
		get {
			let df = DateFormatter()
			df.dateFormat = "MMMM YYYY"
			return selectedDate.ordinal() + " " + df.string(from: selectedDate)
		}
	}
	
	func saveModel() {
		model = ConsultModel(profileImage: nil, firstName: nil, lastName: nil, date: selectedDate, qualification: nil)
		goNextSegue!()
	}

}
