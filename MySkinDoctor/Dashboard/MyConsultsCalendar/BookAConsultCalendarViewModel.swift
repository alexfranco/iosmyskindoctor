//
//  BookAConsultCalendarViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class BookAConsultCalendarViewModel: BaseViewModel {
	
	var timeslots: [String] = []
	
	var selectedDate = Date() {
		didSet {
			selectedDateUpdated!(selectedDate)
		}
	}
	
	var selectedDateUpdated: ((_ date: Date)->())?
	var timeslotsUpdated: (()->())?
	
	var monthLabelText: String {
		get {
			return selectedDate.ordinalMonthAndYear()
		}
	}
	
	var shouldShowEmptyTimeSlotsLabel: Bool {
		get {
			return timeslots.count == 0
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
				self.timeslots = [Date().timeAndDateText, Date().adjust(.hour, offset: 1).timeAndDateText, Date().adjust(.hour, offset: 1).timeAndDateText, Date().adjust(.hour, offset: 2).timeAndDateText, Date().adjust(.hour, offset: 3).timeAndDateText, Date().adjust(.hour, offset: 4).timeAndDateText]
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
			
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
	
	func getItemAtIndexPath(_ row: Int) -> String {
		return timeslots[row]
	}
	
	override func saveModel() {
		super.saveModel()
		goNextSegue!()
	}

}
