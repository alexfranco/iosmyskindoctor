//
//  BookAConsultThankYouViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 07/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class BookAConsultThankYouViewModel: BaseViewModel {
	
	var model: ConsultModel!
	
	var doctorNameText: String {
		get {
			if let firstName = model.firstName, let lastName = model.lastName {
				return firstName + " " + lastName
			} else {
				return  "-"
			}
		}
	}
	
	var profileImage: UIImage {
		get {
			return (model.profileImage == nil ? UIImage(named: "logo") : model.profileImage)!
		}
	}
	
	var qualificationsText: String {
		get {
			return model.qualification == nil ? "-" : model.qualification!
		}
	}
	
	var appointmentDateText: String {
		get {
			return String.init(format: "%@ @ %@", dateText(), timeText())
		}
	}
	
	required init(model: ConsultModel) {
		super.init()
		self.model = model
	}
	
	
	func dateText() -> String {
		let df = DateFormatter()
		df.dateFormat = "MMMM YYYY"
		return model.date.ordinal() + " " + df.string(from: model.date)
	}
		
	func timeText() -> String {
		let df = DateFormatter()
		df.dateFormat = "HH.ss a"
		df.amSymbol = "am"
		df.pmSymbol = "pm"
		return df.string(from: model.date)
	}
		
}
