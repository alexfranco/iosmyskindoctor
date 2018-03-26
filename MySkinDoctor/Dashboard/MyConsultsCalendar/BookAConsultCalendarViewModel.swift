//
//  BookAConsultCalendarViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class BookAConsultCalendarViewModel: BaseViewModel {
	
	var timeslots: [String] = [String]()
	
	var selectedDate = Date() {
		didSet {
			selectedDateUpdated!(selectedDate)
		}
	}
	
	var selectedDateUpdated: ((_ date: Date)->())?
	
	var monthLabelText: String {
		get {
			return selectedDate.ordinalMonthAndYear()
		}
	}
	
	override init() {
		super.init()
		
		 timeslots = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
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
