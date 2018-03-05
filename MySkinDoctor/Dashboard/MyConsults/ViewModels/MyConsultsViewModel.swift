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
	
	var sectionsInTable = [String]()
	
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
		allItems = [ConsultModel(profileImage: nil, firstName: "Dr Grey", lastName: "Yellow", date: Date(), qualification: "none")]
		
		createDateSections(models: allItems)
	}
	
	func refreshData() {
		refresh!()
	}
	
	func createDateSections(models: [ConsultModel]) {
		for model in models {
			let dateString = (DateUtils.getOrdinaryDay(date: model.date!) + " " + dateFormater.string(from: model.date!)).uppercased()
			
			// create sections NSSet so we can use 'containsObject'
			let sections: NSSet = NSSet(array: sectionsInTable)
			
			// if sectionsInTable doesn't contain the dateString, then add it
			if !sections.contains(dateString) {
				sectionsInTable.append(dateString)
			}
		}
	}
	
	func getSectionItems(section: Int) -> [ConsultModel] {
		var sectionItems = [ConsultModel]()
		
		// loop through the testArray to get the items for this sections's date
		for model in allItems {
			let dateString = (DateUtils.getOrdinaryDay(date: model.date!) + " " + dateFormater.string(from: model.date!)).uppercased()

			// if the item's date equals the section's date then add it
			if dateString == sectionsInTable[section] {
				sectionItems.append(model)
			}
		}
		
		return sectionItems
	}
	
	func getNumberOfSections() -> Int {
		return sectionsInTable.count
	}
	
	func getSectionTitle(section: Int) -> String {
		return sectionsInTable[section]
	}
	
	func getDataSourceCount(section: Int) -> Int {
		return getSectionItems(section: section).count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> ConsultModel {
		var models = getSectionItems(section: indexPath.section)
		return models[indexPath.row]
	}
}

