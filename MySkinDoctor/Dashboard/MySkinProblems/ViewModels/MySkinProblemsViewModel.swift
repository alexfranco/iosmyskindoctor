//
//  MySkinProblemsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemsViewModel: BaseViewModel {
	
	enum DiagnosesSegmentedEnum: Int {
		case all
		case undiagnosed
		case diagnosed
	}
	
	static let undiagnosedSection = 0
	static let diagnosedSection = 1
	
	var refresh: (()->())?

	var selectedSegmented = DiagnosesSegmentedEnum.all {
		didSet {
			refresh!()
		}
	}
	
	var allItems = [SkinProblems]()
	var undiagnosedItems = [SkinProblems]()
	var diagnosedItems = [SkinProblems]()

	override init() {
		// Generate tests
		
		if let results = DataController.fetchAll(type: SkinProblems.self) {
			allItems = results
			diagnosedItems = allItems.filter { (model) -> Bool in model.isDiagnosed }
			undiagnosedItems = allItems.filter { (model) -> Bool in !model.isDiagnosed }
		}
	}
	
	func refreshData() {
		refresh!()
	}
	
	func getHeaderBackgroundColor(section: Int) -> UIColor {
		switch selectedSegmented {
		case .all:
			return section == MySkinProblemsViewModel.undiagnosedSection ? AppStyle.mySkinUndiagnosedColor : AppStyle.mySkinDiagnosedColor
		case .undiagnosed:
			return AppStyle.mySkinUndiagnosedColor
		case .diagnosed:
			return AppStyle.mySkinDiagnosedColor
		}
	}
	
	func getSectionTitle(section: Int) -> String {
		var headerTitle: String!
		
		switch selectedSegmented {
		case .all:
			headerTitle = section == MySkinProblemsViewModel.undiagnosedSection ? "Undiagnosed (%d)" : "Diagnosed (%d)"
		case .undiagnosed:
			headerTitle = "Undiagnosed (%d)"
		case .diagnosed:
			headerTitle = "Diagnosed (%d)"
		}
		
		return String.init(format: headerTitle.uppercased(), getDataSourceCount(section: section))
	}
	
	func getDataSourceCount(section: Int) -> Int {
		switch selectedSegmented {
		case .all:
			return section == MySkinProblemsViewModel.undiagnosedSection ? undiagnosedItems.count : diagnosedItems.count
		case .undiagnosed:
			return undiagnosedItems.count
		case .diagnosed:
			return diagnosedItems.count
		}
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblems {
		switch selectedSegmented {
		case .all:
			return indexPath.section == MySkinProblemsViewModel.undiagnosedSection ? undiagnosedItems[indexPath.row] : diagnosedItems[indexPath.row]
		case .undiagnosed:
			return undiagnosedItems[indexPath.row]
		case .diagnosed:
			return diagnosedItems[indexPath.row]
		}
	}
	
	func getNumberOfSections() -> Int {
		switch selectedSegmented {
		case .all:
			let dataSourceCount = getDataSourceCount(section: MySkinProblemsViewModel.undiagnosedSection) > 0 || getDataSourceCount(section: MySkinProblemsViewModel.diagnosedSection) > 0
			return dataSourceCount ? 2 : 0
		case .undiagnosed:
			return getDataSourceCount(section: MySkinProblemsViewModel.undiagnosedSection) > 0 ? 1 : 0
		case .diagnosed:
			return getDataSourceCount(section: MySkinProblemsViewModel.undiagnosedSection) > 0 ? 1 : 0
		}
	}
}
