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
		
		refreshData()
	}
	
	func refreshData() {
		allItems = DataController.fetchAll(type: Consultation.self)!
		
		allItems.sort { (modelA, modelB) -> Bool in
			return modelA.appointmentDate! as Date > modelB.appointmentDate! as Date
		}
		
		upcomingItems = allItems.filter { (model) -> Bool in (model.appointmentDate! as Date) >= Date() }
		historyItems = allItems.filter { (model) -> Bool in (model.appointmentDate! as Date) < Date() }
		
		sectionsInTableAll = createDateSections(models: allItems)
		sectionsInTableUpcoming = createDateSections(models: upcomingItems)
		sectionsInTableHistory = createDateSections(models: historyItems)
		
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
		for model in allItems {
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
	
	func getNumberOfSections() -> Int {
		return getSectionsInTable(consultSegmentedEnum: selectedSegmented).count
	}
	
	func getSectionTitle(section: Int) -> String {
		return  getSectionsInTable(consultSegmentedEnum: selectedSegmented)[section]
	}
	
	func getDataSourceCount(section: Int) -> Int {
		return getSectionItems(section: section).count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> Consultation {
		var models = getSectionItems(section: indexPath.section)
		return models[indexPath.row]
	}
	
	func getHeaderBackgroundColor(section: Int) -> UIColor {
		return (getSectionItems(section: section).first?.appointmentDate)! as Date > Date() ? AppStyle.consultTableViewHeaderBGColor : AppStyle.consultTableViewHeaderBGColorDisabled
	}
	
	func getHeaderTextColor(section: Int) -> UIColor {
		return (getSectionItems(section: section).first?.appointmentDate)! as Date > Date() ? AppStyle.consultTableViewHeaderTextColor : AppStyle.consultTableViewHeaderTextColorDisabled
	}
	
}
