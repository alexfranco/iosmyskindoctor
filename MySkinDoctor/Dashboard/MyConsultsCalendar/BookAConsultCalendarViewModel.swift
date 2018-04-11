//
//  BookAConsultCalendarViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

class BookAConsultCalendarViewModel: BaseViewModel {
	
	var model: SkinProblems!
	
	var timeslots: [AppointmentsResponseModel] = []
	
	var selectedDate = Date() {
		didSet {
			selectedDateUpdated!(selectedDate)
		}
	}
	
	var selectedAppointment: AppointmentsResponseModel? {
		didSet {
			selectedDate = (selectedAppointment?.start)!
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
	
	required init(skinProblemsManagedObjectId: NSManagedObjectID) {
		self.model = DataController.getManagedObject(managedObjectId: skinProblemsManagedObjectId) as? SkinProblems
	}
	
	func fetchTimeslots() {
	
		var startOfDayForDate = selectedDate.startOfDayForDate()
		if startOfDayForDate.isDateToday() {
			startOfDayForDate = Date().adjust(.hour, offset: 1)
		} else if startOfDayForDate < Date() { // is in the past
			timeslots = []
			self.nextButtonUpdate!(self.isNextButtonEnabled)
			self.timeslotsUpdated!()
			return
		}
		
		isLoading = true
		ApiUtils.getTimeslots(accessToken: DataController.getAccessToken(), skinProblemsId: Int(model.skinProblemId), startDate: startOfDayForDate, endDate: selectedDate.endOfDayForDate()) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let models):
				print("getTimeslots")
				self.timeslots = models as! [AppointmentsResponseModel]

				if let first = self.timeslots.first {
					self.selectedAppointment = first
				}
				
			case .failure(_, _):
				print("getTimeslots error")
				self.timeslots = []
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
	
	func getItemAtIndexPath(_ row: Int) -> AppointmentsResponseModel {
		return timeslots[row]
	}
	
	override func saveModel() {
		super.saveModel()
		goNextSegue!()
	}

}
