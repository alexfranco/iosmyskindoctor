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
	var model: Consultation!
	var profileImage: UIImage?
	var displayName: String?
	var time: String?
	var qualification: String?
	var dateFormatString = "HH:ss"
	
	var isInThePast = false
	
	required init(model: Consultation) {
		super.init()
		self.model = model
		
		if let doctor = model.doctor {
			
			if let profileImage = doctor.profilePicture as? UIImage {
				self.profileImage = profileImage
			}
			
			if let firstName = doctor.firstName, let lastName = doctor.lastName {
				self.displayName = firstName + " " + lastName
			} else {
				self.displayName  = "-"
			}
			
			qualification = doctor.qualifications ?? "-"
		}
		
		if let appointmentDate = model.appointmentDate as Date? {
			let df = DateFormatter()
			df.dateFormat = dateFormatString
			self.time = df.string(from: appointmentDate)
			isInThePast = appointmentDate < Date()
		}
	}
	
}

