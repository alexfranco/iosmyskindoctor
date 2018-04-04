//
//  BookAConsultCalendarViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class BookAConsultCalendarViewModel: BaseViewModel {
	
	var timeslots: [TimeslotViewModel] = []
	
	var selectedDate = Date() {
		didSet {
			selectedDateUpdated!(selectedDate)
		}
	}

	var nextButtonUpdate: ((_ show: Bool)->())?
	var selectedDateUpdated: ((_ date: Date)->())?
	var timeslotsUpdated: (()->())?
	
	var monthLabelText: String {
		get {
			return timeslots.count == 0 ? selectedDate.ordinalMonthAndYear(): selectedDate.ordinalMonthAndYear() + " " + selectedDate.timeText
		}
	}
	
	var shouldShowEmptyTimeSlotsLabel: Bool {
		get {
			return timeslots.count == 0
		}
	}
	
	var isNextButtonEnabled: Bool {
		get {
			return timeslots.count > 0
		}
	}
	
	override init() {
		super.init()
	}
	
	func fetchTimeslots() {
		isLoading = true
	
		ApiUtils.getTimeslots(accessToken: DataController.getAccessToken(), date: selectedDate) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("getTimeslots")
				self.timeslots = [TimeslotViewModel(model: TimeslotModel(startDate: Date(), endDate: Date().adjust(.hour, offset: 1))),
								  TimeslotViewModel(model: TimeslotModel(startDate: Date().adjust(.hour, offset: 1), endDate: Date().adjust(.hour, offset: 2)))]

				if let first = self.timeslots.first {
					self.selectedDate = first.date
				}
				
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
			
			self.nextButtonUpdate!(self.isNextButtonEnabled)
			self.timeslotsUpdated!()
		}
	}
	
	var numberOfComponentsInPickerView: Int {
		get {
			return 1
		}
	}
	
	var numberOfItems: Int {
		get {
			return timeslots.count
		}
	}
	
	func getItemAtIndexPath(_ row: Int) -> TimeslotViewModel {
		return timeslots[row]
	}
	
	override func saveModel() {
		super.saveModel()
		goNextSegue!()
	}

}
