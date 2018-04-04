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
	
	var model: TimeslotModel
	
	var date: Date {
		get {
			return model.startDate
		}
	}
	
	var timeslotDisplayText: String {
		get {
			 return String.init("\(model.startDate.timeText) - \(model.endDate.timeText)")
		}
	}
	
	required init(model: TimeslotModel) {
		self.model = model
	}
	
	
}
