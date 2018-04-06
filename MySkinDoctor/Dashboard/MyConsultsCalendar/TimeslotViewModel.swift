//
//  TimeslotViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class TimeslotViewModel: BaseViewModel {
	
	var model: AppointmentsResponseModel
	
	var start: Date {
		get {
			return model.start!
		}
	}
	
	var timeslotDisplayText: String {
		get {
			 return String.init("\(model.start!.timeText) - \(model.end!.timeText)")
		}
	}
	
	required init(model: AppointmentsResponseModel) {
		self.model = model
	}
	
	
}
