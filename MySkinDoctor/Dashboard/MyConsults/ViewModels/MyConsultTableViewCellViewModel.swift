//
//  MyConsultTableViewCellViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MyConsultTableViewCellViewModel: BaseViewModel {
	var model: ConsultModel!
	var profileImage: UIImage?
	var displayName: String?
	var time: String?
	var qualification: String?
	var dateFormatString = "HH:ss"
	
	required init(model: ConsultModel) {
		super.init()
		self.model = model
		self.profileImage = model.profileImage

		if let firstName = model.firstName, let lastName = model.lastName {
			self.displayName = firstName + " " + lastName
		} else {
			self.displayName  = "-"
		}

		let df = DateFormatter()
		df.dateFormat = dateFormatString

		self.time = df.stringFromDate(model.date)
		self.qualification = model.qualification
	}
}

