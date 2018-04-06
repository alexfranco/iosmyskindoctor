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
	var appointmentDate: Date?
	var isInThePast = false

	required init(model: Consultation) {
		super.init()
		self.model = model
		
		if let doctor = model.doctor {
			
			if let profileImage = doctor.profilePicture as? UIImage {
				self.profileImage = profileImage
			} else {
				self.profileImage = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
			}
			
			self.displayName = doctor.displayName ?? "-"
			qualification = doctor.qualifications?.uppercased() ?? "-"
		}
		
		if let appointmentDate = model.appointmentDate as Date? {
			let df = DateFormatter()
			df.dateFormat = dateFormatString
			self.time = df.string(from: appointmentDate)
			isInThePast = appointmentDate < Date()
			
			self.appointmentDate = appointmentDate
		}
	}
	
	func tableViewCellBackgroundColor() -> UIColor {
		return isBeforeConsultation() ? AppStyle.myConsultTableViewCellUpcomingBackground : AppStyle.myConsultTableViewCellHistoryBackground
	}
	
	private func isBeforeConsultation() -> Bool {
		let now = Date()
		if let appointmentDate = appointmentDate {
			return appointmentDate > now
		}
		return false
	}
	
}

