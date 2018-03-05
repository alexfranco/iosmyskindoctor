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
	
	var dateFormater = DateFormatter()

	enum ConsultSegmentedEnum: Int {
		case all
		case upcoming
		case history
	}
	
	var sectionsInTableAll = [String]()
	var sectionsInTableUpcoming = [String]()
	var sectionsInTableHistory = [String]()
	
	var refresh: (()->())?
	
	var selectedSegmented = ConsultSegmentedEnum.all {
		didSet {
			refresh!()
		}
	}
	
	var allItems = [ConsultModel]()
	var upcomingItems = [ConsultModel]()
	var historyItems = [ConsultModel]()
	
	override init() {
		super.init()
		dateFormater.dateFormat = "MMMM, yyyy"
		
		// Generate tests
		allItems = [ConsultModel(profileImage: nil, firstName: "Dr Yellow", lastName: "Kun", date: Date().adjust(.day, offset: -6), qualification: "Past"),
					ConsultModel(profileImage: nil, firstName: "Dr Red", lastName: "Sama", date: Date().adjust(.day, offset: 6), qualification: "Upcoming")]
		
		allItems.sort { (modelA, modelB) -> Bool in
			return modelA.date > modelB.date
		}
		
		upcomingItems = allItems.filter { (model) -> Bool in model.date >= Date() }
		historyItems = allItems.filter { (model) -> Bool in model.date < Date() }
		
		sectionsInTableAll = createDateSections(models: allItems)
		sectionsInTableUpcoming = createDateSections(models: upcomingItems)
		sectionsInTableHistory = createDateSections(models: historyItems)
	}
	
	func refreshData() {
		refresh!()
	}
	
	func createDateSections(models: [ConsultModel]) -> [String] {
		var sections = [String]()

		for model in models {
			let dateString = (model.date.ordinal() + " " + dateFormater.string(from: model.date)).uppercased()
			
			// create sections NSSet so we can use 'containsObject'
			let sectionsSet: NSSet = NSSet(array: sections)
			
			// if sectionsInTable doesn't contain the dateString, then add it
			if !sectionsSet.contains(dateString) {
				sections.append(dateString)
			}
		}
		
		return sections
	}
	
	func getSectionItems(section: Int) -> [ConsultModel] {
		var sectionItems = [ConsultModel]()
		
		// loop through the testArray to get the items for this sections's date
		for model in allItems {
			let dateString = (model.date.ordinal() + " " + dateFormater.string(from: model.date)).uppercased()

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
	
	func getItemAtIndexPath(indexPath: IndexPath) -> ConsultModel {
		var models = getSectionItems(section: indexPath.section)
		return models[indexPath.row]
	}
	
	func getHeaderBackgroundColor(section: Int) -> UIColor {
		return (getSectionItems(section: section).first?.date)! > Date() ? AppStyle.consultTableViewHeaderBGColor : AppStyle.consultTableViewHeaderBGColorDisabled
	}
	
	func getHeaderTextColor(section: Int) -> UIColor {
		return (getSectionItems(section: section).first?.date)! > Date() ? AppStyle.consultTableViewHeaderTextColor : AppStyle.consultTableViewHeaderTextColorDisabled
	}
	
}
