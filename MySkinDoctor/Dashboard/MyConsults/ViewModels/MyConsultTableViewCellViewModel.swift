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
	var profileImageUrl: URL?
	var profilePlaceHolder: UIImage?
	var displayName: String?
	var time: String?
	var qualification: String?
	var dateFormatString = "HH:mm"
	var appointmentDate: Date?
	var isInThePast = false

	required init(model: Consultation) {
		super.init()
		self.model = model
		
		if let skinProblems = model.skinProblems, let diagnose = skinProblems.diagnose, let doctor = diagnose.doctor {
			
			profilePlaceHolder = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
			if let problemImage = doctor.profilePicture as? UIImage {
				profilePlaceHolder = problemImage
			}
			
			profileImageUrl = URL.init(string: doctor.profilePictureUrl ?? "")
			
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
		return model.isBeforeConsultation()
	}
	
}

