//
//  MyConsultsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MyConsultsViewModel: BaseViewModel {
	
	enum ConsultSegmentedEnum: Int {
		case all
		case upcoming
		case history
	}
	
	var sectionsInTableAll = [String]()
	var sectionsInTableUpcoming = [String]()
	var sectionsInTableHistory = [String]()
	
	// Bind properties
	var refresh: (()->())?
	
	var selectedSegmented = ConsultSegmentedEnum.all {
		didSet {
			refresh!()
		}
	}
	
	var allItems = [Consultation]()
	var upcomingItems = [Consultation]()
	var historyItems = [Consultation]()
	
	override init() {
		super.init()
		
		self.loadDBModel()
	}
	
	func refreshData() {
		self.fetchInternetModel()
	}
	
	override func fetchInternetModel() {
		super.fetchInternetModel()
		
		//		isLoading = true
		print("fetchInternetModel")
		ApiUtils.getAllAppointments(accessToken: DataController.getAccessToken()) { (result) in
			//			self.isLoading = false
			print("getAllAppointments")
			
			switch result {
			case .success(let model):
				
				for eventResponseModel in model as! [EventResponseModel] {
					let _ = Consultation.parseAndSaveResponse(consultationResponseModel: eventResponseModel)
				}
				
				self.loadDBModel()
				
				if self.onFetchFinished != nil {
					self.onFetchFinished!()
				}
				
			case .failure(_, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(nil, error)
			}
		}
	}
	
	override func loadDBModel() {
		super.loadDBModel()
	
		if let results = DataController.fetchAll(type: Consultation.self, sortByKey: "appointmentId") {
				
			allItems = results
			allItems = allItems.filter { (model) -> Bool in (model.isCancelled == false) }
			
			allItems.sort { (modelA, modelB) -> Bool in
				return modelB.appointmentDate! as Date > modelA.appointmentDate! as Date
			}
			
			upcomingItems = allItems.filter { (model) -> Bool in (model.appointmentDate! as Date) >= Date() }
			historyItems = allItems.filter { (model) -> Bool in (model.appointmentDate! as Date) < Date() }
			
			sectionsInTableAll = createDateSections(models: allItems)
			sectionsInTableUpcoming = createDateSections(models: upcomingItems)
			sectionsInTableHistory = createDateSections(models: historyItems)
		}
		
		if refresh != nil { refresh!() }
	}
	
	func createDateSections(models: [Consultation]) -> [String] {
		var sections = [String]()

		for model in models {
			let dateString = (model.appointmentDate! as Date).ordinalMonthAndYear().uppercased()
			
			// create sections NSSet so we can use 'containsObject'
			let sectionsSet: NSSet = NSSet(array: sections)
			
			// if sectionsInTable doesn't contain the dateString, then add it
			if !sectionsSet.contains(dateString) {
				sections.append(dateString)
			}
		}
		
		return sections
	}
	
	func getSectionItems(section: Int) -> [Consultation] {
		var sectionItems = [Consultation]()
		
		// loop through the testArray to get the items for this sections's date
		for model in getItems(consultSegmentedEnum: selectedSegmented) {
			let dateString = (model.appointmentDate! as Date).ordinalMonthAndYear().uppercased()

			// if the item's date equals the section's date then add it
			if dateString == getSectionsInTable(consultSegmentedEnum: selectedSegmented) [section] {
				sectionItems.append(model)
			}
		}
		
		return sectionItems
	}
	
	func getSectionsInTable(consultSegmentedEnum: ConsultSegmentedEnum) -> [String] {
		switch consultSegmentedEnum {
		case .all:
			return sectionsInTableAll
		case .upcoming:
			return sectionsInTableUpcoming
		case .history:
			return sectionsInTableHistory
		}
	}
	
	private func getItems(consultSegmentedEnum: ConsultSegmentedEnum) -> [Consultation] {
		switch consultSegmentedEnum {
		case .all:
			return allItems
		case .upcoming:
			return upcomingItems
		case .history:
			return historyItems
		}
	}
	
	func getNumberOfSections() -> Int {
		return getSectionsInTable(consultSegmentedEnum: selectedSegmented).count
	}
	
	func getSectionTitle(section: Int) -> String {
		return getSectionsInTable(consultSegmentedEnum: selectedSegmented)[section]
	}
	
	func getDataSourceCount(section: Int) -> Int {
		return getSectionItems(section: section).count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> Consultation {
		var models = getSectionItems(section: indexPath.section)
		return models[indexPath.row]
	}
	
	func isBeforeConsultation(indexPath: IndexPath) -> Bool {
		let model = getItemAtIndexPath(indexPath: indexPath)
		return model.isBeforeConsultation()
	}
	
	func getHeaderBackgroundColor(section: Int) -> UIColor {
		return (getSectionItems(section: section).first?.appointmentDate)! as Date > Date() ? AppStyle.consultTableViewHeaderBGColor : AppStyle.consultTableViewHeaderBGColorDisabled
	}
	
	func getHeaderTextColor(section: Int) -> UIColor {
		return (getSectionItems(section: section).first?.appointmentDate)! as Date > Date() ? AppStyle.consultTableViewHeaderTextColor : AppStyle.consultTableViewHeaderTextColorDisabled
	}
	
}
